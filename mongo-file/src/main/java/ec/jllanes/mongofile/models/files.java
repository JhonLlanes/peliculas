package ec.jllanes.mongofile.models;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Document(collation = "files")
public class files {
    @Id
    private String id;
    private String filename;
    private String fileType;
    private byte[] file;
    private long fileSize;
}
