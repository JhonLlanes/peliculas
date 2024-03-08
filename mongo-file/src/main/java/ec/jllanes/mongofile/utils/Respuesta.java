package ec.jllanes.mongofile.utils;

import lombok.Data;

@Data
public class Respuesta {
    private int codigo;
    private String mensaje;
    private Object resultado;
}
