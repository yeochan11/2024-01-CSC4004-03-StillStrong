package still88.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
@IdClass(LikePK.class)
@Table(name = "likes")
@Entity
public class Like {

    /**
     * ManyToOne 아무거나 넣어둔거라 수정 필요
     */
    @Id
    @ManyToOne
    @JoinColumn(name="userId", nullable = false)
    private User userId;

    /**
     * ManyToOne 아무거나 넣어둔거라 수정 필요
     */
    @Id
    @ManyToOne
    @JoinColumn(name="recipeId", nullable = false)
    private Recipe recipeId;


}
