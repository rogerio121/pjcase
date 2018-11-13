package br.com.pjcase.controller;

import br.com.pjcase.dao.DaoGrafico;
import br.com.pjcase.model.DadoParaGrafico;
import br.com.pjcase.util.Data;
import com.google.gson.Gson;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControllerGraficos {

    @RequestMapping("/graficos")
    public ModelAndView chamarTelaGraficos(){
        DaoGrafico daoGrafico = new DaoGrafico();
        String dadosGraficoJson = "";

        dadosGraficoJson = new Gson().toJson(daoGrafico.buscarCasosParaGraficoCasosPorUsuário());

        ModelAndView mv = new ModelAndView("graficos");
        mv.addObject("dadosCasosPorUsuario",dadosGraficoJson);

        return mv;
    }

    @PostMapping("/buscacasosporusuariofiltrado")
    public ResponseEntity<String> filtrarGraficoCasosPorUsuário(@RequestBody String filtros){
        DaoGrafico daoGrafico = new DaoGrafico();
        String dadosGraficoJson = "";

        String[] filtrosSplit = filtros.split(",");
        String status = filtrosSplit[1];
        String dataInicio = Data.formatarFataFormatoBanco(filtrosSplit[2]);
        String dataFim = Data.formatarFataFormatoBanco(filtrosSplit[3]);

        dadosGraficoJson = new Gson().toJson(daoGrafico.buscarCasosParaGraficoCasosPorUsuário(status, dataInicio,dataFim));

        return  ResponseEntity.ok(dadosGraficoJson);
    }
}
