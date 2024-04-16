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

    @Id
    @Column(name="userId", nullable = false)
    private int userId;

    @Id
    @Column(name="recipeId", nullable = false)
    private int recipeId;
}
