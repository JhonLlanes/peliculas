package ec.jllanes.mongofile.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoadFile {
    private String filename;
    private String fileType;
    private long fileSize;
    private byte[] file;
}
