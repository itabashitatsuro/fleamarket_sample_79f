$(function(){
    //DataTransferオブジェクトで、データを格納する箱を作る
    var dataBox = new DataTransfer();
    //querySelectorでfile_fieldを取得し変数に入れている
    var file_field = document.querySelector('input[type=file]')
    
    //file(#image-box-1)が変化した時に発火するイベント
    $('#image-box-1').on("change",`input[type="file"]`,function(){
    //選択したファイル情報を取得し変数に格納 - 最後の[0]は最初のファイルという意味
    var files = $('input[type=file]').prop('files')[0];
    
    //$.each()で、配列やハッシュに対して繰り返し処理を行う
    $.each(this.files, function(i,file){
    
    //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
    var fileReader = new FileReader();
    
    //DataTransferオブジェクトに対して、fileを追加
    dataBox.items.add(file) //ステップ②
    //dataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
    //file_field.files =  dataBox.files //ステップ②
    
    // file_fieldのnameに動的なindexをつける為の配列
    let num = [1,2,3,4,5];
    lastIndex = $('.input-field__contents:last').data('index');
    num.splice(0, lastIndex);
    // 画像用のinputにそれぞれ異なる番号付与する記述
      const buildFileField = (index)=> {
        const html = `<div data-index="${index}" class="input-field__contents">
                        <input id:"img-file" type="file"
                        name="item[images_attributes][${index}][item_image]"
                        id="item_images_attributes_${index}_item_image"><br>
                      </div>`;
        return html;
      }
    
    $('#image-box__container').append(buildFileField(num[0]));
    
    //fileReader.readAsDataURL(file)で画像の読み込み。
    fileReader.readAsDataURL(file);
    
    //読み込みが完了すると、srcにfileのURLを格納
    fileReader.onloadend = function() {
      var src = fileReader.result
      var html = `<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="140" height="150" >
                      </div>
                    </div>
                    <div class='item-image__operetion'>
                      <div class='item-image__operetion--delete'>削除</div>
                    </div>
                  </div>`
     //image_box__container要素の前にhtmlを差し込む
      $('#image-box__container').before(html);
    };
     //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
      //$('#image-box__container').attr('class', `item-num-${num}`)
    });
  });

    $(document).on("click", '.item-image__operetion--delete', function(){
      //プレビュー要素を取得
      var target_image = $(this).parent().parent()
      //プレビューを削除
      target_image.remove();
      //inputタグに入ったファイルを削除
      file_field.remove()
    })



    //画像を追加した時に、labelのfor属性の値を新しいinputのidに変える記述
    $(document).on("change", '#img-file', function(){
      var result = $('label').attr('for', 'item_images_attributes_1_item_image');
    })
    $(document).on("change", '#item_images_attributes_1_item_image', function(){
      var result = $('label').attr('for', 'item_images_attributes_2_item_image');
    })
    $(document).on("change", '#item_images_attributes_2_item_image', function(){
      var result = $('label').attr('for', 'item_images_attributes_3_item_image');
    })
    $(document).on("change", '#item_images_attributes_3_item_image', function(){
      var result = $('label').attr('for', 'item_images_attributes_4_item_image');
    })
    $(document).on("change", '#item_images_attributes_4_item_image', function(){
      var result = $('label').attr('for', 'item_images_attributes_5_item_image');
    })
    //最後のファイル選択した時に、boxを隠す
    $(document).on("mouseenter", '#item_images_attributes_5_item_image', function(){
      var deletes = $('#image-box__container')
      deletes.css('display', 'none');
    })
});