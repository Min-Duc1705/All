package vn.project.magic_english.model.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IELTSQuestionResponse {
    private Long id;
    private Integer questionNumber;
    private String questionText;
    private String questionType;
    private String passage; // Cho Reading
    private String audioUrl; // Cho Listening
    private List<IELTSAnswerResponse> answers;
}
