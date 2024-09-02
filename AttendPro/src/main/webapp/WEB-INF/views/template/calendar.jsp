<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

<style>
  #calendar {
    max-width: 100%;
    height: 400px;
    margin: 0 auto;
  }
  .fc-day-sat, .fc-day-sun {
    color: red !important;
  }
  .fc-event {
    color: white;
  }
  .fc-event-title {
    text-align: center;
    line-height: 1.5;
  }
</style>

<div id="calendar"></div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

    // JSON 문자열을 JavaScript 배열로 변환
    var holidaysJson = '${holidaysJson}';
    console.log("Holidays JSON: " + holidaysJson); // JSON 데이터 확인
    var holidays = JSON.parse(holidaysJson);
   
    // FullCalendar 설정
    var calendar = new FullCalendar.Calendar(calendarEl, {
        headerToolbar: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        initialView: 'dayGridMonth',
        editable: false,
        expandRows: true,
        events: holidays.map(holiday => {
            var date = new Date(holiday.holidayDate);
            var formattedDate = date.toISOString().split('T')[0];
            return {
                title: '휴일',
                start: formattedDate,
                color: 'red'
            };
        }),
        dayCellDidMount: function(info) {
            var date = info.date;
            if (date.getDay() === 0 || date.getDay() === 6) {
                info.el.style.color = 'red';
            }
        }
    });

    calendar.render();
});
</script>