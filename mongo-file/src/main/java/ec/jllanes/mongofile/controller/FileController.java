package ec.jllanes.mongofile.controller;

import com.mongodb.client.gridfs.model.GridFSFile;
import ec.jllanes.mongofile.models.LoadFile;
import ec.jllanes.mongofile.service.GridFsService;
import ec.jllanes.mongofile.utils.Mensaje;
import ec.jllanes.mongofile.utils.Respuesta;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/files")
@CrossOrigin("*")
public class FileController {

    @Autowired
    private GridFsService gridFsService;

    @PostMapping
    public ResponseEntity<?> handleFileUpload(@RequestParam("file") MultipartFile file) throws IOException {
        Respuesta respuesta = new Respuesta();
        respuesta.setCodigo(Mensaje.CODIGO_OK);
        respuesta.setResultado(gridFsService.storeFile(file));
        respuesta.setMensaje("ok");

//        return new ResponseEntity<>(, HttpStatus.OK);
        return ResponseEntity.ok(respuesta);
    }

    @GetMapping("/{fileId}")
    public ResponseEntity<?> handleFileDownload(@PathVariable String fileId) {
        LoadFile file = gridFsService.getFile(fileId);
        // Lógica para descargar el archivo como un array de bytes
        if (file == null) {
            return ResponseEntity.ok("no existe documento");
        }

        String extension = FilenameUtils.getExtension(file.getFilename());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);

        switch (extension.toLowerCase()) {
            case "pdf":
                headers.setContentType(MediaType.APPLICATION_PDF);
                break;
            case "jpg":
            case "jpeg":
                headers.setContentType(MediaType.IMAGE_JPEG);
                break;
            case "png":
                headers.setContentType(MediaType.IMAGE_PNG);
                break;
            case "gif":
                headers.setContentType(MediaType.IMAGE_GIF);
                break;
            default:
                // Manejar el caso predeterminado o desconocido si es necesario
                break;
        }

        headers.add("Content-Disposition", "inline; filename=" + file.getFilename());
        return new ResponseEntity<>(file.getFile(), headers, HttpStatus.OK);

//        return ResponseEntity.ok().body(file); // Reemplaza bytes con el contenido del archivo
    }
}
