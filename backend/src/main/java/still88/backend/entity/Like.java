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
@Table(name = "like")
@Entity
public class Like {

    @Id
    @ManyToOne
    @JoinColumn(name="userId", nullable = false)
    private User userId;

    @Id
    @ManyToOne
    @JoinColumn(name="recipeId", nullable = false)
    private Recipe recipeId;


}
