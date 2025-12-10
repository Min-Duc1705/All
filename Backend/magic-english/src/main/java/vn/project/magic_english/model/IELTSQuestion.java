package vn.project.magic_english.model;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "ielts_questions")
@Getter
@Setter
public class IELTSQuestion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_id", nullable = false)
    @JsonIgnore
    private IELTSTest test;

    @Column(name = "question_number", nullable = false)
    private Integer questionNumber;

    @Column(name = "question_text", nullable = false, columnDefinition = "TEXT")
    private String questionText;

    @Column(name = "question_type", length = 50)
    private String questionType; // multiple_choice, true_false, fill_blank

    @Column(columnDefinition = "TEXT")
    private String passage; // Đoạn văn cho Reading

    @Column(name = "audio_url", columnDefinition = "TEXT")
    private String audioUrl; // Link audio cho Listening

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<IELTSAnswer> answers = new ArrayList<>();

    @Column(name = "created_at")
    private Instant createdAt;

    @PrePersist
    public void handleBeforeCreate() {
        this.createdAt = Instant.now();
    }
}
