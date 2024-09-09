<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
    color: red;
    background-color: transparent;
    border: none;
  }
  .fc-event-title {
    text-align: center;
    line-height: 1.5;
  }
  .selected-day {
    background-color: rgba(0, 0, 255, 0.2) !important;
  }
  .btn-my {
    padding: 8px 15px;
    font-size: 16px;
    color: #fff;
    background-color: #3498db;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  .btn-my:hover {
    background-color: #2980b9;
  }
</style>

<div id="calendar"></div>
<button class="btn-my" id="addHolidays">휴일 추가</button>
<button class="btn-my" id="removeHolidays">휴일 삭제</button>

<script>
$(document).ready(function() {
    var calendarEl = document.getElementById('calendar');
    var holidaysJson = '${holidaysJson}';
    var holidays = JSON.parse(holidaysJson);
    var selectedDates = [];

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
                id: formattedDate,
                title: '휴일',
                start: formattedDate,
                backgroundColor: 'transparent',
                borderColor: 'transparent',
                textColor: 'red'
            };           
        }),
        
        dayCellDidMount: function(info) {
            var date = info.date;
            var dateStr = formatDateToISO(date);

            if (date.getDay() === 0 || date.getDay() === 6) {
                info.el.style.color = 'red';
            }

            $(info.el).on('click', function() {
                var dateStr = formatDateToISO(date);
                var index = selectedDates.indexOf(dateStr);

                if (index === -1) {
                    selectedDates.push(dateStr);
                    $(info.el).addClass('selected-day');
                } else {
                    selectedDates.splice(index, 1);
                    $(info.el).removeClass('selected-day');
                }

                console.log("Selected Dates: ", selectedDates);
            });
        }
    });

    calendar.render();

    $('#addHolidays').on('click', function() {
        if (selectedDates.length > 0) {
            $.ajax({
                url: '${pageContext.request.contextPath}/rest/holi/addMultiple',
                type: 'POST',
                data: {
                    companyId: '${companyDto.companyId}',
                    holidayDates: selectedDates.join(',')
                },
                success: function(response) {
                    console.log(response);
                    selectedDates.forEach(date => {
                        var event = {
                            id: date,
                            title: '휴일',
                            start: date,
                            color: 'red'
                        };
                        if (!calendar.getEventById(date)) {
                            calendar.addEvent(event);
                        }
                    });
                    selectedDates = [];
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        } else {
            alert('선택된 날자가 없습니다.');
        }
    });

    $('#removeHolidays').on('click', function() {
        if (selectedDates.length > 0) {
            $.ajax({
                url: '${pageContext.request.contextPath}/rest/holi/deleteMultiple',
                type: 'POST',
                data: {
                    companyId: '${companyDto.companyId}',
                    holidayDates: selectedDates.join(',')
                },
                success: function(response) {
                    console.log(response);
                    selectedDates.forEach(date => {
                        var event = calendar.getEventById(date);
                        if (event) {
                            event.remove();
                        }
                    });
                    selectedDates = [];
                    location.reload();
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        } else {
            alert('선택된 날자가 없습니다.');
        }
    });

    function formatDateToISO(date) {
        return new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate())).toISOString().split('T')[0];
    }
});
</script>
