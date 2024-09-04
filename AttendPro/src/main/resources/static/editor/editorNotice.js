$(function(){
    //$(선택자).summernote(옵션객체);
    $("[name=noticeContent]").summernote({
        height: 250,//높이(px)
        minHeight: 250,//최소높이(px)
        maxHeight: 400,//최대높이(px)

        placeholder: "내용 입력",//공란 시 표시될 도움말

        //메뉴 설정
        toolbar: [
            //['메뉴명', ['버튼명', '버튼명', ...]]
            ['area', ['style', 'undo', 'redo']],
            ['style', ['bold', 'italic', 'underline', 'strikethrough']],
            ['font', ['fontname', 'fontsize', 'forecolor', 'backcolor']],
            ['tool', ['ol', 'ul', 'table', 'hr', 'fullscreen']],
            ['attach', ['picture']],
        ],

        //콜백 설정
        callbacks: {
            //이벤트명 : 함수
            onImageUpload : function(files) {
                
                //시나리오
                //1. 파일업로드는 원래 form에 post방식, multipart/form-data여야 한다
                //2. 상황상 form을 쓸 수가 없다(form은 게시글 등록에 사용)
                //3. ajax를 이용하여 파일을 업로드를 할 예정
                //4. ajax를 이용하여 Form으로 post방식, multiart 전송이 가능하도록 구현
                //  --------------------> 서버로 파일 전송
                //  <-------------------- 서버에서 다운로드 주소를 전송해줘야 함
                //5. img 태그를 생성해서 다운로드 주소를 설정
                //6. 에디터에 추가

                //*중요* 
                //form이 없어도 FormData라는걸 쓰면 같은 효과 발생
                //.append(이름, 파일 또는 값)을 추가한다
                var form = new FormData();
				//dnd한 파일 수 만큼 반복하여 FormData에 첨부
				for(var i=0; i < files.length; i++) {
	                form.append("attach", files[i]);
				}

                $.ajax({
                    processData: false, /*파일업로드에 꼭 필요한 설정*/
                    contentType: false, /*파일업로드에 꼭 필요한 설정*/
                    url:"/rest/notice/uploads",
                    method:"post",
                    data: form,
                    success:function(response){
                        //response에는 파일번호 목록이 있어야 한다
						for(var i=0; i < response.length; i++) {
							//태그를 만들 때에는 선택자에 온전한 태그를 넣는다
	                        var tag = $("<img>").addClass("notice-attach")
	                        			.attr("data-key", response[i])
	                        			.attr("src", "/attach/download?attachmentNo="+response[i]);
	                        $("[name=noticeContent]").summernote("insertNode", tag[0]);
						}
                        
                    }
                });
            }
        },
    });

    //if(에디터가 비어있으면) {
    if($("[name=noticeContent]").summernote("isEmpty")) {
        //에디터의 값을 빈 문자열로 재설정하세요
        $("[name=noticeContent]").summernote("code", "");
    }
    
});