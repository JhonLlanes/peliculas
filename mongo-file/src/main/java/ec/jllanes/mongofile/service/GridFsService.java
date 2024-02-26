package ec.jllanes.mongofile.service;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.gridfs.model.GridFSFile;
import ec.jllanes.mongofile.models.LoadFile;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsOperations;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class GridFsService {

    @Autowired
    private GridFsTemplate gridFsTemplate;

    @Autowired
    private GridFsOperations operations;

    public String storeFile(MultipartFile file) throws IOException {
        // Lógica para almacenar el archivo en GridFS

        DBObject metadata = new BasicDBObject();
        metadata.put("fileSize", file.getSize());

        Object fileID = gridFsTemplate.store(file.getInputStream(), file.getOriginalFilename(), file.getContentType(), metadata);

        return fileID.toString();


//        return gridFsTemplate.store(file.getInputStream(), file.getOriginalFilename()).toString();
    }

    public LoadFile getFile(String fileId) {
        // Lógica para recuperar un archivo de GridFS
        GridFSFile gridFSFile = gridFsTemplate.findOne(Query.query(Criteria.where("_id").is(fileId)));
        LoadFile loadFile = new LoadFile();
        try {

            if (gridFSFile != null && gridFSFile.getMetadata() != null) {

                loadFile.setFilename(gridFSFile.getFilename());

                loadFile.setFileType(gridFSFile.getMetadata().get("_contentType").toString());

                loadFile.setFileSize((Long) gridFSFile.getMetadata().get("fileSize"));

                loadFile.setFile(IOUtils.toByteArray(operations.getResource(gridFSFile).getInputStream()));


            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }


        return loadFile;
    }
}
