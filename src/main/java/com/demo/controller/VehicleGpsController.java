package com.demo.controller;

import com.demo.dao.entity.VehicleGps;
import com.demo.dto.input.SpeedParam;
import com.demo.dto.input.TransportParam;
import com.demo.service.VehicleGpsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by wwwwei on 18/1/8.
 */
@Controller
@RequestMapping(value = "/vehicle")
public class VehicleGpsController {
    @Autowired
    private VehicleGpsService vehicleGpsService;

    @RequestMapping(value = "/transport/list.do")
    @ResponseBody
    public Object listVehicleGpsByAddressAndDate(TransportParam transportParam) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        Date endDate = null;
        if (transportParam.getStartDate() != null && !transportParam.getStartDate().equals("")) {
            startDate = sdf.parse(transportParam.getStartDate());
        }
        if (transportParam.getEndDate() != null && !transportParam.getEndDate().equals("")) {
            endDate = sdf.parse(transportParam.getEndDate());
        }
        List<VehicleGps> vehicleGpses = vehicleGpsService.listVehicleGps(transportParam.getAddress(), startDate, endDate);
        return vehicleGpses;
    }

    @RequestMapping(value = "/speed/list.do")
    @ResponseBody
    public Object listVehicleGpsByAddressAndSpeed(SpeedParam speedParam) throws ParseException {
        Date startDate = null;
        Date endDate = null;
        if (speedParam.getStartTime() != null) {
            startDate = new Date(speedParam.getStartTime());
        }
        if (speedParam.getEndTime() != null) {
            endDate = new Date(speedParam.getEndTime());
        }
        List<VehicleGps> vehicleGpses = vehicleGpsService.listVehicleGps(null, startDate, endDate);
        return vehicleGpses;
    }
}
