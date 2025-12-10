package vn.project.magic_english.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;

/**
 * Proxy controller to stream audio from external TTS APIs
 * This solves CORS and compatibility issues with audioplayers on mobile
 */
@RestController
@RequestMapping("/api/audio")
@Slf4j
@CrossOrigin(origins = "*")
public class AudioProxyController {

    @Value("${voicerss.api-key:}")
    private String voiceRssApiKey;

    /**
     * Proxy endpoint to stream audio from VoiceRSS or other TTS services
     * Usage: GET /api/audio/proxy?url=<encoded_audio_url>
     */
    @GetMapping(value = "/proxy", produces = "audio/mpeg")
    public ResponseEntity<InputStreamResource> proxyAudio(@RequestParam String url) {
        try {
            log.info("Proxying audio from URL: {}", url);

            URL audioUrl = new URL(url);
            URLConnection connection = audioUrl.openConnection();
            connection.setRequestProperty("User-Agent", "Mozilla/5.0");
            connection.setConnectTimeout(10000);
            connection.setReadTimeout(10000);

            InputStream inputStream = connection.getInputStream();
            InputStreamResource resource = new InputStreamResource(inputStream);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.parseMediaType("audio/mpeg"));
            headers.add("Accept-Ranges", "bytes");
            headers.add("Cache-Control", "public, max-age=3600");

            log.info("Successfully streaming audio");
            return ResponseEntity.ok()
                    .headers(headers)
                    .body(resource);

        } catch (Exception e) {
            log.error("Error proxying audio: {}", e.getMessage(), e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * Direct audio endpoint - generates TTS on demand
     * Usage: GET /api/audio/tts?text=<encoded_text>
     * Uses API key from application.yaml config
     */
    @GetMapping(value = "/tts", produces = "audio/mpeg")
    public ResponseEntity<InputStreamResource> generateTTS(@RequestParam(name = "text") String text) {
        try {
            // Decode the text in case it's URL encoded
            try {
                text = java.net.URLDecoder.decode(text, java.nio.charset.StandardCharsets.UTF_8);
            } catch (Exception e) {
                log.warn("Could not decode text, using as-is");
            }

            log.info("Generating TTS for text length: {} chars", text.length());

            // Build VoiceRSS URL using configured API key
            String encodedText = java.net.URLEncoder.encode(text, java.nio.charset.StandardCharsets.UTF_8);
            String voiceRssUrl = "https://api.voicerss.org/?key=" + voiceRssApiKey +
                    "&hl=en-us&v=Linda&src=" + encodedText +
                    "&c=MP3&f=44khz_16bit_mono&r=-2";

            URL audioUrl = new URL(voiceRssUrl);
            URLConnection connection = audioUrl.openConnection();
            connection.setRequestProperty("User-Agent", "Mozilla/5.0");
            connection.setConnectTimeout(30000);
            connection.setReadTimeout(60000);

            InputStream inputStream = connection.getInputStream();

            // Read all bytes first to avoid streaming issues
            byte[] audioBytes = inputStream.readAllBytes();
            inputStream.close();

            // Check for error response
            if (audioBytes.length < 1000) {
                String response = new String(audioBytes, java.nio.charset.StandardCharsets.UTF_8);
                if (response.contains("ERROR")) {
                    log.error("VoiceRSS error: {}", response);
                    return ResponseEntity.internalServerError().build();
                }
            }

            InputStreamResource resource = new InputStreamResource(
                    new java.io.ByteArrayInputStream(audioBytes));

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.parseMediaType("audio/mpeg"));
            headers.setContentLength(audioBytes.length);
            headers.add("Accept-Ranges", "bytes");
            headers.add("Cache-Control", "public, max-age=3600");

            log.info("Successfully generated TTS audio, size: {} bytes", audioBytes.length);
            return ResponseEntity.ok()
                    .headers(headers)
                    .body(resource);

        } catch (Exception e) {
            log.error("Error generating TTS: {}", e.getMessage(), e);
            return ResponseEntity.internalServerError().build();
        }
    }

    /**
     * Simple test endpoint to verify audio streaming works
     */
    @GetMapping(value = "/test", produces = "audio/mpeg")
    public ResponseEntity<String> testAudio() {
        return ResponseEntity.ok("Audio proxy is working");
    }
}
