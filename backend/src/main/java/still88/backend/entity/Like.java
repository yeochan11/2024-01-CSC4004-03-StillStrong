package still88.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@IdClass(LikePK.class)
@Table(name = "like")
@Entity
public class Like {
    @Id
    @Column(name="userId", nullable = false)
    private int userId;

    @Id
    @Column(name="recipeId", nullable = false)
    private int recipeId;
}
