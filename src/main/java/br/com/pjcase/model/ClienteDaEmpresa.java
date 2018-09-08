package br.com.pjcase.model;

public class ClienteDaEmpresa {
    String cpfCliente;
    String idEmpresa;

    public String getCpfCliente() {
        return cpfCliente;
    }

    public void setCpfCliente(String cpfCliente) {
        this.cpfCliente = cpfCliente;
    }

    public String getIdEmpresa() {
        return idEmpresa;
    }

    public void setIdEmpresa(String idEmpresa) {
        this.idEmpresa = idEmpresa;
    }

    @Override
    public String toString() {
        return "ClienteDaEmpresa{" +
                "cpfCliente='" + cpfCliente + '\'' +
                ", idEmpresa='" + idEmpresa + '\'' +
                '}';
    }
}
