//新
package {
	import flash.display.*;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.events.*;
	import flash.display.MovieClip;
	import XML;
	import flash.net.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.LocalConnection;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
	import flash.geom.*;
	import flash.geom.Point;
	import flash.text.*;
	import flash.text.TextFieldAutoSize;
	import flash.external.ExternalInterface;
	import flash.system.System;
	import fl.transitions.*;
	import fl.transitions.easing.*;
	
	import org.papervision3d.cameras.*;
	import org.papervision3d.view.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.primitives.*
	import org.papervision3d.materials.utils.*;
	import org.papervision3d.core.render.sort.NullSorter;
	import org.papervision3d.typography.Text3D;
	import org.papervision3d.typography.fonts.HelveticaBold;
	import org.papervision3d.typography.Letter3D;
	import org.papervision3d.materials.special.Letter3DMaterial;
	import flashx.textLayout.formats.Float;
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import fl.controls.Button;
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	import fl.controls.Label;
	import fl.controls.TextArea;
	import fl.controls.ScrollPolicy;
	

	
	
	[SWF(backgroundColor="#ffffff",width="1000",height="1000")]
	public class PasQk extends BasicView {	
	
	var mwidth:int = 600;//map領域の横幅指定
	var mheight:int = 300;//map領域の縦幅指定
	
	var rend:Array = new Array();//画像切り替え判定のrange_end
	var rstart:Array = new Array();//画像切り替え判定のrange_start
	var src : String;//画像のsource
	var meta:XML;
	var xml:XML;//PCD格納用
	var ccd:XML;//CCD格納用
	var bmd:XML;
	var pcd_name:String;
	var ccd_name:String;
	var bmd_name:String;
	
	var len : int;
	var p_len : int;
	var snorth : int;
	var loader:Loader = new Loader();//メインの画像ローダ
	var fullon : Loader = new Loader();
	var fulloff : Loader = new Loader();
	var btn : Loader = new Loader();
				
	var bmddata:String;
	var usebmd:String;
	var subbmddata:Array = new Array();
	var subusebmd:Array = new Array();
	var bmdswlat:String;
	var bmdswlng:String;
	var bmdnelat:String;
	var bmdnelng:String;
	var clat:Number;
	var clng:Number;
	var subbmdswlat:Array = new Array();
	var subbmdswlng:Array = new Array();
	var subbmdnelat:Array = new Array();
	var subbmdnelng:Array = new Array();
	var n_floor:String;
	var floor_cont:String;
	var floor_cont_name:String;
	
	var panoid:Number;//パノラマＩＤ格納
	var id1 :String;
	var ch:Number;//チェンジパノラマカウンター
	var chid:Array = new Array();//チェンジパノラマＩＤ格納用配列
	var north:Number;//北位置変数
	var startdir:int;//スタート方位
	var cn:int;//content数カウンター
	var n_bmp_data : BitmapData;//newBitmapData用（新しい画像を読み込むBitmapData）
	var n_loader:Loader = new Loader();//newLoader用（新しい画像を読み込むLoader）
	var moving : int;//移動用変数(+1,-1,0)、+1なら前進、-1なら後進、0なら移動なし
	var moving_damy : int;//movingの値を保持するための変数
	var lat:Number;//メインパノラマの緯度
	var lng:Number;//メインパノラマの経度
	var ch_lat: Array = new Array();//チェンジパノラマの緯度
	var ch_lng: Array = new Array();//チェンジパノラマの経度
	var latsa: Number;//2点の緯度の差＜メインパノラマとコンテンツの距離に使用＞
	var lngsa: Number;//2点の経度の差＜同上＞
	var pi : Number = 3.1415926535;//円周率
	
	var fa:Number;//for文用開始変数
	var la:Number;//for文用終了変数
	var pm:Number;//for文用増減変数(+1 or -1)
	var rad:Number;//cameraの角度
	var leng:Number;//中心点からのカメラの距離
	var range:Number;//中心点からのカメラの角度
					
	var level:int = 0;//バグ取り用
						
	var xsa:Number;//cameraのx座標の移動距離
	var ysa:Number;//cameraのy座標の移動距離(正確にはz座標)
	var un_leng:Number;//xsaとysaを利用した移動距離
	var lengsa:Number;//un_lengとlengの移動距離の差
	var i:int;//ただのカウンター用変数
	var c_length:Number;//コンテンツの距離
	var c_height:Number;//コンテンツの高さ
	var c_radius:Number;//コンテンツの半径…？
	var c_name:String;//コンテンツの名前
	var c_data:Text3D;//コンテンツデータ

	//var disp_c:Map = new Map();//表示しているコンテンツリスト
	
	//var c_data = new TextField();
	var c_id:String;//コンテンツID
	var contents_lng:Array = new Array();//コンテンツの経度を格納する変数
	var contents_lat:Array = new Array();//コンテンツの緯度を格納する変数
	var letterformat:Letter3DMaterial;//c_data用のフォーマット
	var view_width:Number;
	var view_height:Number;
	//var map:Map = new Map();
	//var marker:Marker;
	var mapld : Loader = new Loader();
	var submapld : Loader = new Loader();
	var mapmarker : Loader = new Loader();
	
	var maskAry : Array = new Array();
	var maskid : Array = new Array();
	var maskwidht : Array = new Array();
	var maskheight : Array = new Array();
	var maskx : Array = new Array();
	var masky : Array = new Array();
	var sp:Sprite = new Sprite();
	
	var text_field = new TextField();
	var bmd_mask:uint;
	var cont_line:int;
	var img:String;
	var bmpd: BitmapData = new BitmapData(mwidth, mheight, false, 0xFFFFFF);
    var bmp: Bitmap = new Bitmap(bmpd);
	var subbmpd: BitmapData;
	var subbmp: Bitmap;
	var al:Number = 1;
	var forword : Loader = new Loader();//前進用画像読み込みローダー
	var back : Loader = new Loader();//後進用画像読み込みローダー
	var right : Loader = new Loader();//右視点移動用画像読み込みローダー
	var left : Loader = new Loader();//左視点移動用画像読み込みローダー
	var up : Loader = new Loader();//上視点移動用画像読み込みローダー
	var down : Loader = new Loader();//下視点移動用画像読み込みローダー
	var myTextArea:TextArea = new TextArea();
				
	
	var debug:Number = 0;
	
		public function PasQk() {
			stage.align = StageAlign.TOP;
			var viewport:Viewport3D = new Viewport3D(900,350,false,false);//Viewportの準備(パノラマ画像表示)
			super(900, 350, false, false, CameraType.FREE);//camera設定
			view_width = viewport.viewportWidth;
			view_height = viewport.viewportHeight;
			
			var metaloader:URLLoader = new URLLoader;
			metaloader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			metaloader.addEventListener(Event.COMPLETE,complete_meta);
			metaloader.load(new URLRequest("resource/meta.xml"));
							
			function complete_meta(event:Event):void{
				meta = new XML(event.target.data);
				pcd_name = "resource/" +meta.InitialDataUrl.PCD.@src;
				ccd_name = "resource/" + meta.InitialDataUrl.CCD.@src;
				bmd_name = "resource/" +meta.InitialDataUrl.BMD.@src;

				var bmdloader:URLLoader = new URLLoader;//ccdloaderの宣言＜XMLを読み込む＞
				bmdloader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				bmdloader.addEventListener(Event.COMPLETE,complete_bmd);//completeイベント。読み込み完了してくれる。
				bmdloader.load(new URLRequest(bmd_name));//URLRequestでccd.xmlを読み込む
				
				function complete_bmd(event:Event):void{//CCD読み込み終了後
					bmd = new XML(event.target.data);//event.target.dataにより関数complete_ccdを呼んだccdloaderの内容を格納
					
					var bmd_len:uint = bmd.maps.img.length();//ccd.xml内のContentの長さ（数）を格納
					bmd_mask = bmd.maps.masks.length();
					for(cn=0;cn<bmd_len;cn++){
						if(cn == 0){
							bmddata = bmd.maps[cn].img.@src;//各contentの経度を格納
							usebmd="image/"+bmddata;
							bmdswlat = bmd.maps[cn].data.@swlat;
							bmdswlng = bmd.maps[cn].data.@swlng;
							bmdnelat = bmd.maps[cn].data.@nelat;
							bmdnelng = bmd.maps[cn].data.@nelng;
						}
						else{
							subbmddata[cn-1] = bmd.maps[cn].img.@src;//各contentの経度を格納
							subusebmd[cn-1]="image/"+subbmddata;
							subbmdswlat[cn-1] = bmd.maps[cn].data.@swlat;
							subbmdswlng[cn-1] = bmd.maps[cn].data.@swlng;
							subbmdnelat[cn-1] = bmd.maps[cn].data.@nelat;
							subbmdnelng[cn-1] = bmd.maps[cn].data.@nelng;
						}
					}
				clat = Math.abs(parseFloat(bmdswlat) - parseFloat(bmdnelat));
				clng = Math.abs(parseFloat(bmdswlng) - parseFloat(bmdnelng));
				clat = Number(clat.toFixed(6));
				clng = Number(clng.toFixed(6));
				//trace(clat + "," + clng);
					for(cn=0;cn<bmd_mask;cn++){
						maskid[cn]  =bmd.maps.masks[cn].@id;
						maskwidht[cn]  =bmd.maps.masks[cn].@width;
						maskheight[cn] =bmd.maps.masks[cn].@height;
						maskx[cn]      =bmd.maps.masks[cn].@x;
						masky[cn]      =bmd.maps.masks[cn].@y;
					}
				}
				
				
				var ccdloader:URLLoader = new URLLoader;//ccdloaderの宣言＜XMLを読み込む＞
				ccdloader.addEventListener(Event.COMPLETE,complete_ccd);//completeイベント。読み込み完了してくれる。
				ccdloader.load(new URLRequest(ccd_name));//URLRequestでccd.xmlを読み込む
				
				function complete_ccd(event:Event):void{//CCD読み込み終了後
					ccd = new XML(event.target.data);//event.target.dataにより関数complete_ccdを呼んだccdloaderの内容を格納
					
					var ccd_len:uint = ccd.Contents.floor.Content.length();//ccd.xml内のContentの長さ（数）を格納
					for(cn=0;cn<ccd_len;cn++){
						contents_lng[cn] = ccd.Contents.floor.Content[cn].coords.@lng;//各contentの経度を格納
						contents_lat[cn] = ccd.Contents.floor.Content[cn].coords.@lat;//各contentの緯度を格納
						
					}
				}
				
				
				
				var pcdloader:URLLoader = new URLLoader;//pcdを読み込むLoader
				pcdloader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
				pcdloader.addEventListener(Event.COMPLETE,complete_pcd);//COMPLETEハンドラ
				pcdloader.load(new URLRequest(pcd_name));//pcd読み込み(コンテンツごとに変更)
				
				function complete_pcd(event:Event):void{
						xml = new XML(event.target.data);//complete_pcdを呼んだpcdloaderの情報を格納  
					var paramid : String;
					var id : String;
					var dir:String;
					var param:Object = loaderInfo.parameters;
					paramid = param["id"];
					dir = param["dir"];
					if(paramid != null){
	
					id = paramid.split("pano").join("");
					id = "pano" + id;
					}
					else{
					id = xml.Panoramas.@startpano;//.split("pano").join("");
					////panoid = pano256などとなっている"pano"を除いた数字をidに格納
					}
					if(dir != null){
						startdir = int(dir);
						snorth = startdir;
					}
					else{
					startdir = xml.Panoramas.@startdir;	
					snorth = startdir;
					}
					len = xml.Panoramas.Panorama.(@panoid == id).chpanos.chpano.length();
					p_len = xml.Panoramas.Panorama.length();
					//startpanoのchpano（チェンジパノラマ）数を格納
					for(ch=0; ch<len; ch++){//チェンジパノラマの情報の読み込み
						rend[ch] = xml.Panoramas.Panorama.(@panoid == id).chpanos.chpano[ch].range.@end;//切替可能角度の終点
//						rend[ch] = xml.Panoramas.Panorama.(@panoid= id).chpanos.chpano[ch].range.@end;//切替可能角度の終点
						rstart[ch] = xml.Panoramas.Panorama.(@panoid == id).chpanos.chpano[ch].range.@start;//切替可能角度の始点
						chid[ch] = xml.Panoramas.Panorama.(@panoid == id).chpanos.chpano[ch].@panoid.split("pano").join("");//chpanoのID
						ch_lat[ch] = xml.Panoramas.Panorama.(@panoid == "pano" + chid[ch]).coords.@lat;//chpanoの緯度
						ch_lng[ch] = xml.Panoramas.Panorama.(@panoid == "pano" + chid[ch]).coords.@lng;//chpanoの経度
					}
//					panoid = xml.Panoramas.Panorama.(@panoid == id).split("pano").join("");//startpanoのid
					panoid = xml.Panoramas.@startpano.split("pano").join("");//startpanoのid
					src = xml.Panoramas.Panorama.(@panoid == id).img.@src;//startpanoの画像のソース
					north = xml.Panoramas.Panorama.(@panoid == id).direction.@north;//startpanoの北情報
					lat = xml.Panoramas.Panorama.(@panoid == id).coords.@lat;//startpanoの緯度を
					lng = xml.Panoramas.Panorama.(@panoid == id).coords.@lng;//startpanoの経度
					//snorth=north;
				}
			}
			
			addEventListener(Event.ENTER_FRAME, loadloop);//Event-Enter_FRAMEいわゆる無限ループ
			function loadloop(event:Event):void{//XMLの処理が遅いので処理が終わるまで無限ループ
				if(src !=null){
				 removeEventListener(Event.ENTER_FRAME, loadloop);
				start();
				}
			}
			
		}
		protected function onIOError(e:IOErrorEvent): void {
  //bra bra bra
  trace(e);
}
		function start(){//ここからメイン					
			var material:BitmapMaterial;//パノラマ画像をはるBitmapData
			var sphere:Sphere = new Sphere(material, 800, 20, 10);//BitmapDataを張り付ける球体マテリアル
			
			loader.load(new URLRequest("resource/"+src));//パノラマ画像を読み込む
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,comHandler);//パノラマ画像読み込み完了ハンドラー
			function comHandler(e:Event){
				
				var panoheight:Number = (750-loader.height)/2;//パノラマ画像をBitmapDataの真ん中に張り付けるための値
				var bmp_data : BitmapData = new BitmapData(1500,750);//BitmapDataの準備1500ｘ750
				var matrix : Matrix = new Matrix(-1,0,0,1,1500,panoheight);//matrixにより画像を左右反転
				var color : ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);//color指定
				var rect : Rectangle = new Rectangle(0,0,1500,750);//rentangle指定
				bmp_data.draw(loader, matrix, color, BlendMode.NORMAL, rect, true);//LoaderからBitmapdataに貼り付け
				material = new BitmapMaterial(bmp_data,true);//マテリアルにBitmapDataを格納
				sphere = new Sphere(material,500,30,30);//球体マテリアルにマテリアルを適用
				
				material.smooth = true;//画像のスムージング処理
				
				forword.load(new URLRequest("image/forword.jpg"));//前進用のボタンの画像を読み込む
				back.load(new URLRequest("image/back.jpg"));//以下省略
				right.load(new URLRequest("image/right.jpg"));
				left.load(new URLRequest("image/left.jpg"));
				up.load(new URLRequest("image/up.jpg"));
				down.load(new URLRequest("image/down.jpg"));
				fullon.load(new URLRequest("image/big.jpg"));
				fulloff.load(new URLRequest("image/small.jpg"));
				//btn.load(new URLRequest("image/logo.png"));
				
				forword.x = stage.stageWidth -210;//ボタンの配置位置をFlashの窓情報から一定位置に
				forword.y = stage.stageHeight -250;//配置できるよう、stageの横幅縦幅を利用して
				back.x = stage.stageWidth - 210;//ボタンの配置位置を指定
				back.y = stage.stageHeight - 200;
				right.x= stage.stageWidth - 160;
				right.y= stage.stageHeight - 250;
				left.x = stage.stageWidth - 260;
				left.y = stage.stageHeight - 250;
				up.x = stage.stageWidth - 110;
				up.y = stage.stageHeight - 250;
				down.x = stage.stageWidth - 110;
				down.y = stage.stageHeight - 200;
				fullon.x = stage.stageWidth -75;
				fullon.y = stage.stageHeight - 150;
				fulloff.x = stage.stageWidth - 75;
				fulloff.y = stage.stageHeight - 150;
				
				//btn.x = stage.stageWidth - 250;
				//btn.y = stage.stageHeight - 250;
				
							
				forword.name = "1";//前進時+1
				back.name = "-1";//後進時-1
				right.name = "1";//右振り時+1
				left.name = "-1";//左振り時-1
				up.name = "-1";//上向き時-1
				down.name = "1";//下向き時+1
				fullon.name = "1";
				fulloff.name = "-1";
				//btn.name = "1";
				
				
				// カメラを原点に配置
				camera.x = camera.y = camera.z = 0;
				sphere.rotationY = -90;//sphereにずれがあるため修正
				sphere.rotationY -= north*0.24;//さらに修正
				//camera.rotationY -= (443 - 340)*0.24; //cameraの向きを変更
				camera.rotationY = startdir;
				// 画質を「低」にして高速化もあり
				stage.quality = StageQuality.BEST;
				
				material.opposite = true;
				
				addChild(forword);//画像を窓上に張り付ける
				addChild(back);
				addChild(right);
				addChild(left);
				addChild(up);
				addChild(down);
				addChild(fullon);
				//addChild(btn);
				
				viewport.x = (stage.stageWidth - viewport.viewportWidth)/2;
				//viewport.y = (stage.stageHeight - viewport.viewportHeight)/2;
				scene.addChild(sphere);//球体を窓上に張り付ける
				
					var ary:Array = new Array();
					var ary1:Array = new Array();
					var ary2:Array = new Array();
						n_floor = xml.Panoramas.@startfloor;
						floor_cont = xml.Panoramas.@startcont;
						floor_cont_name = xml.Panoramas.@startname;
					var ccd_len1:uint = ccd.Contents.floor.length();
					//var ccd_len2:uint = ccd.Contents.floor.(@no == n_floor).Content.length();
					//var ccd_len3:uint = ccd.Contents.floor.(@no == n_floor).Content.length();
					
				for(i=0;i<ccd_len1;i++){
					var cnt_name:String= ccd.Contents.floor[i].@no;
					var cnt_floor:String= "../"+cnt_name+"/PasQk.swf";
					ary[i] ={label:cnt_name, data:cnt_floor}; 
				}
				/*	
				for(i=0;i<ccd_len2;i++){
					var cnt_floor1:String= "../"+"../"+n_floor+"/"+ccd.Contents.floor.(@no == n_floor).Content[i].@contentid+"/PasQk.swf";
					var cnt_name1:String= ccd.Contents.floor.(@no == n_floor).Content[i].detail.@name;			
						ary1[i] ={label:cnt_name1, data:cnt_floor1}; 
				}
				var cnt_i:int=0;
				for(i=0;i<ccd_len2;i++){
					var cnt_floor2:String= "content/"+ccd.Contents.floor.(@no == n_floor).Content[i].(@contentid == "00" || @contentid == floor_cont).img.@thumbsrc;
					var cnt_name2:String= ccd.Contents.floor.(@no == n_floor).Content[i].detail.@name;
					
					trace(cnt_name2);
					trace(cnt_floor2);
					trace(floor_cont);
					if(cnt_name2 != null && cnt_floor2 != "content/"){
					ary2[cnt_i] ={label:cnt_name2, data:cnt_floor2};
					cnt_i++;
					}
				}
				*/
				
					var _textFormat = new TextFormat("_等幅", 20);
					var cmb : ComboBox = new ComboBox();
					//cmb.dropdownWidth = 100;
					//cmb.width = 100;
					cmb.move(700, 400);
					cmb.setSize(100,35);
					cmb.prompt = "選択";
					cmb.dropdown.rowHeight =35;
					cmb.setStyle("textFormat", _textFormat);
					cmb.textField.setStyle("textFormat", _textFormat);
					cmb.dropdown.setStyle("textFormat", _textFormat);
					cmb.dropdown.setRendererStyle("textFormat", _textFormat);
					cmb.textField.setStyle("textFormat", _textFormat);
					cmb.dropdown.setRendererStyle("textFormat", _textFormat);
					cmb.dataProvider = new DataProvider(ary);
					cmb.addEventListener(Event.CHANGE, changeHandler);
					addChild(cmb);
					
					/*
					var cmb1 : ComboBox = new ComboBox();
					//cmb1.dropdownWidth = 100;
					//cmb1.width = 100;
					cmb1.move(780, 400);
					cmb1.setSize(100,35);
					cmb1.prompt = "利用別";
					cmb1.dropdown.rowHeight =50;
					cmb1.setStyle("textFormat", _textFormat);
					cmb1.textField.setStyle("textFormat", _textFormat);
					cmb1.dropdown.setStyle("textFormat", _textFormat);
					cmb1.dropdown.setRendererStyle("textFormat", _textFormat);
					cmb1.textField.setStyle("textFormat", _textFormat);
					cmb1.dropdown.setRendererStyle("textFormat", _textFormat);
					cmb1.dataProvider = new DataProvider(ary1);
					cmb1.addEventListener(Event.CHANGE, changeHandler);
					if(cmb1.length!=0){
					addChild(cmb1);
					}
					
					var cmb2 : ComboBox = new ComboBox();
					//cmb1.dropdownWidth = 100;
					//cmb1.width = 100;
					cmb2.move(880, 400);
					cmb2.setSize(100,35);
					cmb2.prompt = "詳細";
					cmb2.dropdown.rowHeight =50;
					cmb2.setStyle("textFormat", _textFormat);
					cmb2.textField.setStyle("textFormat", _textFormat);
					cmb2.dropdown.setStyle("textFormat", _textFormat);
					cmb2.dropdown.setRendererStyle("textFormat", _textFormat);
					cmb2.textField.setStyle("textFormat", _textFormat);
					cmb2.dropdown.setRendererStyle("textFormat", _textFormat);
					cmb2.dataProvider = new DataProvider(ary2);
					cmb2.addEventListener(Event.CHANGE, CLICKHandler);
					if(cmb2.length!=0){
					addChild(cmb2);
					}
					*/
					/*img=ccd.Contents.floor.(@no == n_floor).Content.(@contentid == floor_cont).img.@thumbsrc;
					var myButton:Button = new Button();
					myButton.label = "詳細";
					myButton.emphasized = true;
					//myButton.width = 100;
					myButton.setStyle("fontSize",100);
					myButton.setSize(80,50);
					myButton.move(860, 400);
					myButton.setStyle("textFormat", _textFormat);
					myButton.addEventListener(MouseEvent.CLICK, CLICKHandler);
					if(img != ""){
					addChild(myButton);
					}*/
					
					
					//myTextArea.wordWrap = false;
					/*
					//myTextArea.horizontalScrollPolicy = ScrollPolicy.ON;
					var text:String;
					if(floor_cont_name == ""){
						text="現在: "+n_floor;//+" panoid"+panoid;
					}else{
						text="現在: "+n_floor+"  利用形式: "+floor_cont_name;//+" panoid"+panoid;
					}
					
						myTextArea.text = text
						myTextArea.setSize(180, 24);
					
					
					myTextArea.move(700, 360);
					addChild(myTextArea);
					*/
					
					
				
				//マウス操作によるイベント群
				right.addEventListener(MouseEvent.MOUSE_DOWN, rl_slide);//右ボタンをドラッグしたときのイベント(rl_slide関数へ)
				left.addEventListener(MouseEvent.MOUSE_DOWN, rl_slide);//左ボタンをドラッグしたときのイベント(rl_slide関数へ）
				//ここで同じ関数を使っているが、左右に振り向ける＜nameプロパティを活用＞
				forword.addEventListener(MouseEvent.MOUSE_DOWN, fb_slide);//前進ボタンをドラッグしたときのイベント
				back.addEventListener(MouseEvent.MOUSE_DOWN, fb_slide);//以下省略
				up.addEventListener(MouseEvent.MOUSE_DOWN, u_d_slide);
				down.addEventListener(MouseEvent.MOUSE_DOWN, u_d_slide);
				fullon.addEventListener(MouseEvent.CLICK, full_slide);
				fulloff.addEventListener(MouseEvent.CLICK, full_slide);
				
				
				viewport.addEventListener(MouseEvent.MOUSE_DOWN, slide);//パノラマ画像表示部のドラッグ			
			mapld.load(new URLRequest("image/"+bmddata));
			submapld.load(new URLRequest(subusebmd[0]));
			mapmarker.load(new URLRequest("image/mm_20_white.png"));
			//addChild(mapld);
			mapld.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			//submapld.contentLoaderInfo.addEventListener(Event.COMPLETE,onSubComplete);
				// レンダリングを開始
				startRendering();
				
			}
			
			function mapchange(id:String = null):Function{
			return function mapchange(event:Event):void {
				id1 = "pano"+ id;
				lat = xml.Panoramas.Panorama.(@panoid == "pano" + id).coords.@lat;
				lng = xml.Panoramas.Panorama.(@panoid == "pano" + id).coords.@lng;
				for(ch=0; ch<xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano.length(); ch++){
						rend[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].range.@end;
						rstart[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].range.@start;
						chid[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].@panoid.split("pano").join("");
						ch_lat[ch] = xml.Panoramas.Panorama.(@panoid == "pano" + chid[ch]).coords.@lat;
						ch_lng[ch] = xml.Panoramas.Panorama.(@panoid == "pano" + chid[ch]).coords.@lng;
				}
    			panoid = xml.Panoramas.Panorama.(@panoid == id1).@panoid.split("pano").join("");
				north = xml.Panoramas.Panorama.(@panoid == id1).direction.@north;
				n_loader.load(new URLRequest("resource/"+ xml.Panoramas.Panorama.(@panoid == id1).img.@src));
				n_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,texture);
				//removeChild(sp);
						sp.x = (stage.stageWidth - 920 +((lng - Number(bmdswlng))*(mwidth/clng)));
						sp.y = (stage.stageHeight - 620 +mheight- ((lat - Number(bmdswlat))*(mheight/clat)));//*(600/500)); 
					//trace(mapmarker.x);
					//addChild(sp);
			}
			}
			
			function onComplete(event:Event):void{
				var pw:int = mapld.content.width;
    			var ph:int = mapld.content.height;
				var subpw:int = submapld.content.width;
    			var subph:int = submapld.content.height;
				var pwe:int = ((subbmdnelng[0] - Number(bmdswlng))*(mwidth/clng)-(subbmdswlng[0] - Number(bmdswlng))*(mwidth/clng));
    			var pns:int = ((subbmdnelat[0] - Number(bmdswlat))*(mheight/clat)-(subbmdswlat[0] - Number(bmdswlat))*(mheight/clat));
					subbmpd = new BitmapData(pwe, pns, false, 0xFFFFFF);
					subbmp = new Bitmap(subbmpd);
    			
    			var matrix1:Matrix = new Matrix();
				var matrix2:Matrix = new Matrix();
					matrix1.scale(mwidth /pw, mheight/ph);
					bmpd.draw(mapld,matrix1);
				
					bmp.x = stage.stageWidth - 920;
					bmp.y = stage.stageHeight - 620;
					addChild(bmp);
									
					matrix2.scale(pwe/subpw, pns/subph);
					subbmpd.draw(submapld,matrix2);
					subbmp.x = (stage.stageWidth - 920 +((subbmdswlng[0] - Number(bmdswlng))*(mwidth/clng)));
					subbmp.y = (stage.stageHeight - 620 +mheight- ((subbmdnelat[0] - Number(bmdswlat))*(mheight/clat)));//*(600/500)); 
					addChild(subbmp);
					
					for(i = 0; i< bmd_mask ; i++){
					maskAry[i] = new Sprite();
					maskAry[i].graphics.beginFill(0x00ffff);
					maskAry[i].graphics.drawRect(0, 0, maskwidht[i], maskheight[i]);
					maskAry[i].graphics.endFill();
					addChild(maskAry[i]);
					maskAry[i].alpha = 0; 
					maskAry[i].x=maskx[i];
					maskAry[i].y=masky[i];
					maskAry[i].addEventListener(MouseEvent.CLICK,mapchange (maskid[i]));
					}
					sp.rotation = camera.rotationY;
					sp.x = (stage.stageWidth - 920 +((lng - Number(bmdswlng))*(mwidth/clng)));
					sp.y = (stage.stageHeight - 620 +mheight- ((lat - Number(bmdswlat))*(mheight/clat)));//*(600/500)); 
					//sp.x = (stage.stageWidth - 920 +((lng - Number(bmdlng))*1000000)*600/500)+mapmarker.width * Math.sin(Math.PI/180 * camera.rotationY)/2;
					//sp.y = (stage.stageHeight -320 +300- ((lat - Number(bmdlat))*1000000)*(300/214))-mapmarker.height * Math.sin(Math.PI/180 * camera.rotationY)/2;//*(600/500));
					//trace(sp.x + "," + sp.y);
						sp.addChild(mapmarker);  //回転させるSpriteに画像を追加
					mapmarker.x = -mapmarker.content.width / 2;  //画像の横幅の半分を左に移動
					mapmarker.y = -mapmarker.content.height / 2;  //画像の高さの半分を上に移動
						addChild(sp);
					//mapmarker.rotation = camera.rotationY;
						//mapmarker.x = (stage.stageWidth - 920 +((lng - Number(bmdlng))*1000000)*600/500)+mapmarker.width * Math.sin(Math.PI/180 * camera.rotationY)/2;
						//mapmarker.y = (stage.stageHeight -320 +300- ((lat - Number(bmdlat))*1000000)*(300/214))-mapmarker.height * Math.sin(Math.PI/180 * camera.rotationY)/2;//*(600/500));
					//addChild(mapmarker);
			}
			
			function onSubComplete(event:Event):void{
				var pwe:int = ((subbmdnelng[0] - Number(bmdswlng))*(mwidth/clng)-(subbmdswlng[0] - Number(bmdswlng))*(mwidth/clng));
    			var pns:int = ((subbmdnelat[0] - Number(bmdswlat))*(mheight/clat)-(subbmdswlat[0] - Number(bmdswlat))*(mheight/clat));
				var subbmpd: BitmapData = new BitmapData(pwe, pns, false, 0xFFFFFF);
				var subbmp: Bitmap = new Bitmap(subbmpd);
				var pw:int = submapld.content.width;
    			var ph:int = submapld.content.height;
				var matrix1:Matrix = new Matrix();
				
					matrix1.scale(pwe/pw, pns/ph);
					subbmpd.draw(submapld,matrix1);
					subbmp.x = (stage.stageWidth - 920 +((subbmdswlng[0] - Number(bmdswlng))*(mwidth/clng)));
					subbmp.y = (stage.stageHeight - 620 +mheight- ((subbmdnelat[0] - Number(bmdswlat))*(mheight/clat)));//*(600/500)); 
					addChild(subbmp);
			}
			
			function changeHandler(event:Event):void {
    			var request:URLRequest = new URLRequest();
    			request.url = ComboBox(event.target).selectedItem.data;
    			navigateToURL(request, "_self");
			}
			
			function CLICKHandler(event:Event):void {
				var request:URLRequest = new URLRequest();
    			request.url = ComboBox(event.target).selectedItem.data;
    			navigateToURL(request, "_blank");
				/*var request:String;
				
					trace("img");
					//if(img != ""){
					request="content/"+img;
    				var url:URLRequest = new URLRequest(request);
    				navigateToURL(url, "_blank");
					//}*/
					trace(request.url);
			}

			
			
			

			//function trace_c(e:MouseEvent):void{//コンテンツをクリックしたときのイベント（現在利用不可）
// 
//			}		
			function slide(e:MouseEvent):void {//マウスの位置により上下左右にカメラの視点を移動
				var Ypoint:Number = mouseY;//ドラッグ時のマウスのY座標を保存
				var Xpoint:Number = mouseX;//ドラッグ時のマウスのX座標を保存
				
				addEventListener(Event.ENTER_FRAME, loop);//ENTER_FRAMEによるループのイベント追加
					
				function loop(e:Event):void{//ループ関数
					var Ymove:Number = (Ypoint - mouseY)*0.03;//ドラッグ時とマウス移動時のマウス座標の差を計算
					var Xmove:Number = (Xpoint - mouseX)*0.03;//その3%をカメラの視点が移動する
					camera.rotationY -= Xmove;
					if(camera.rotationX-Ymove>-20 && camera.rotationX-Ymove < 15){
						camera.rotationX -= Ymove;
						sp.rotation = camera.rotationY;
					}
				}
				stage.addEventListener(MouseEvent.MOUSE_UP, r_loop);//ドラッグ終了時のイベント
				function r_loop(e:MouseEvent):void{//remove_loop
					removeEventListener(Event.ENTER_FRAME, loop);//ENTER_FRAMEによるイベントの除去
					stage.removeEventListener(MouseEvent.MOUSE_UP, r_loop);//ドラッグ終了時のイベントの除去
				}
			}
		
			function u_d_slide(event:MouseEvent):void{//up_down_slide
				moving = event.target.name;//nameプロパティにより+1or-1を取得(これにより上か下かを指定)
				addEventListener(Event.ENTER_FRAME, u_d_loop);//loop関数
				
				function u_d_loop(event:Event):void{//ドラッグ中はずっと動く
					if(moving < 0){
					up.alpha =1;
					}else{
					down.alpha = 1;
					}
					if(camera.rotationX <-20){//角度制限（白いとこが見えないように）
						if(moving > 0){
							camera.rotationX += moving;//
						}
					}
					else if(camera.rotationX > 15){
						if(moving <0){
							camera.rotationX += moving;
						}
					}
					else{
						camera.rotationX += moving;
					}
					stage.addEventListener(MouseEvent.MOUSE_UP, r_u_d_loop);//ドラッグ終了時のイベント
					function r_u_d_loop(event:MouseEvent):void{
						removeEventListener(Event.ENTER_FRAME, u_d_loop);//ループの除去
						stage.removeEventListener(MouseEvent.MOUSE_UP, r_u_d_loop);//ループ除去用のイベントの除去
						if(al <1){
						up.alpha =0.5;
						down.alpha = 0.5;
					}
					}
				}
			}
		
				
			function full_slide(event:MouseEvent):void {
				moving = event.target.name;
				if(moving>0){
				viewport.viewportWidth = stage.stageWidth;//デバッグ、プレビューでの上限1078pix
				viewport.viewportHeight = stage.stageHeight+75;
				viewport.x=0;
				viewport.y=0;
				//stage.displayState = StageDisplayState.FULL_SCREEN;
				camera.zoom = 65;
				//removeChild(map);
				//stage.removeChild(text_field);
				forword.alpha = 0.5;
				back.alpha = 0.5;
				right.alpha = 0.5;
				left.alpha = 0.5;
				up.alpha = 0.5;
				down.alpha = 0.5;
				fulloff.alpha = 0.5;
				al = -1;
				removeChild(sp);
				removeChild(bmp);
				removeChild(subbmp);
				removeChild(fullon);
				addChild(fulloff);
				}
				else{
				viewport.viewportWidth = view_width;
				viewport.viewportHeight = view_height;
				viewport.x = (stage.stageWidth - viewport.viewportWidth)/2;
				//viewport.y = (stage.stageHeight - viewport.viewportHeight)/2;
				//stage.displayState = StageDisplayState.NORMAL;
				camera.zoom = 40;
				//addChild(map);
				//stage.addChild(text_field);
				forword.alpha = 1;
				back.alpha = 1;
				right.alpha =1;
				left.alpha = 1;
				up.alpha = 1;
				down.alpha = 1;
				fullon.alpha = 1;
				al = 1;
				removeChild(fulloff);
				addChild(fullon);
				addChild(bmp);
				addChild(subbmp);
				addChild(sp);
				}

			}
			function rl_slide(event:MouseEvent):void {//right_left_slide
				moving = event.target.name;//nameプロパティにより左右の判定
				addEventListener(Event.ENTER_FRAME, rl_loop);
				
				function rl_loop(event:Event):void{//
					//for(var k :Number = 0; k < 20; k++){//滑らかさがほしいなら//を消してmoving*1をmoving*0.1にする（重くなる）
					camera.rotationY += moving*2;
					snorth += moving*2;
					sp.rotation=camera.rotationY;
					
					if(moving >0){
					right.alpha =1;
					}else{
					left.alpha = 1;
					}
					//trace(camera.rotationY,macos,masin);
					//}
				}
				stage.addEventListener(MouseEvent.MOUSE_UP, st_rl_loop);//いつものごとく除去
				function st_rl_loop(e:MouseEvent):void{
					removeEventListener(Event.ENTER_FRAME, rl_loop);
					stage.removeEventListener(MouseEvent.MOUSE_UP, st_rl_loop);
					if(al <1){
						right.alpha =0.5;
						left.alpha = 0.5;
					}
				}
			 }
		function texture(event:Event){//表示しているパノラマ画像の更新					
				//myTextArea.text = "現在:"+n_floor+"利用形式:"+floor_cont_name+"panoid"+panoid;
					var panoheight:Number = (750-n_loader.height)/2;//いつもの初期設定
					var bmp_data : BitmapData = new BitmapData(1500,750);
					var matrix : Matrix = new Matrix(-1,0,0,1,1500,panoheight);
					var color : ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
					var rect : Rectangle = new Rectangle(0,0,1500,750);
						camera.x=0;//カメラの初期位置を中心点へ
						camera.z=0;//カニ歩きだから、実際は中心点じゃないほうが違和感がない
						sphere.rotationY = -90 - (north*0.24);
						n_bmp_data = new BitmapData(1500,750);//new_bmp_dataを用意
						n_bmp_data.draw(n_loader, matrix, color, BlendMode.NORMAL, rect, true);
						material.texture = n_bmp_data;//materialのtextureに新しいBitmapdataを貼り付け
						n_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,texture);//テクスチャを完了
					
					//removeChild(sp);
						sp.x = (stage.stageWidth - 920 +((lng - Number(bmdswlng))*(mwidth/clng)));
						sp.y = (stage.stageHeight - 620 +mheight- ((lat - Number(bmdswlat))*(mheight/clat)));//*(600/500)); 
					//addChild(sp);
					
					moving = moving_damy;//移動許可
					//addEventListener(Event.ENTER_FRAME,fb_loop);
					leng = Math.sqrt(camera.x * camera.x + camera.z * camera.z);//一応いる？
					level = 0;//いらない子
		}
			function fb_slide(event:MouseEvent):void {//foward_back_slide（ここから本番）
				moving = event.target.name;//前進か後進か
				moving_damy = moving;//movingのダミーを用意
				var material:BitmapMaterial = sphere.material as BitmapMaterial;//ちょっと小細工
				
				var panoheight:Number = (750-loader.height)/2;//前述通り
				var bmp_data : BitmapData = new BitmapData(1500,750);
				var matrix : Matrix = new Matrix(-1,0,0,1,1500,panoheight);
				var color : ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
				var rect : Rectangle = new Rectangle(0,0,1500,750);
				var i :Number;
				if(moving >0){
					forword.alpha =1;
					}else{
					back.alpha = 1;
					}
				
				addEventListener(Event.ENTER_FRAME,fb_loop);
				function fb_loop(event:Event):void{
					
					rad= camera.rotationY/180*pi;//カメラの角度のラジアン
					xsa= camera.x+Math.sin(rad) * moving*3;//rad方向に進むとx方向にxsa進む
					ysa = camera.z+Math.cos(rad) * moving*3;//rad方向に進むとy方向にysa進む
					un_leng = Math.sqrt(xsa*xsa + ysa*ysa);//前述通り
					lengsa= un_leng - leng;
					
					if(moving != 0){//movingが0でなければ、lengを計算
						leng = Math.sqrt(camera.x * camera.x + camera.z * camera.z);
					}
					level++;//不必要
						range = Math.acos( camera.z / leng)*180/pi;//ラジアン⇒角度
					

					if(lengsa >0){//中心から外部へ移動
						if(un_leng < 250){//距離250までの制限
						camera.x += Math.sin(rad) * moving*10;//もともと5
						camera.z += Math.cos(rad) * moving*10;
						}
					}
					else{//中心へ移動
						camera.x += Math.sin(rad) * moving*10;
						camera.z += Math.cos(rad) * moving*10;
						}
					
					if(camera.x < 0){//x座標がマイナスの時
						range = 360 - range;//角度補正
					}
					
					if (leng > 40){//距離が40になったら：切替判定開始
						
						leng = 39;//切替発生中止用(もういらないかも？)
						if(range < 180){//range0-180の間が0⇒ch
							fa = 0;
							la = ch-1;
							pm = 1;
						}
						else{//range180-360の間がch⇒0
							fa = ch-1;
							la = 0;
							pm = -1;
						}
						
						for(i = fa; i!=la+pm ; i+=pm){//切替パノラマ検索
							if(rend[i] - rstart[i] >=0){//rangeend-rangestartが0より大きければ（270-200とか）
								if(rstart[i]<=range && range<=rend[i]){//（200～270とか普通に計算できる）
									moving = 0;//切替中は移動禁止
									id1 = "pano" + chid[i].toString();//id1に切替るパノラマIDを保存
									
									//latsa =Math.abs(lat - ch_lat[i]);
									//lngsa =Math.abs(lng - ch_lng[i]);
									
									lat = ch_lat[i];//latを切り替えるパノラマのものに更新
									lng = ch_lng[i];//lngを切り替えるパノ（ｒｙ
									
									//if((latsa <0.000028) && (lngsa <0.000028)){//lngsaが遠いものには切り替わらないようにしたかった…
										for(ch=0; ch<xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano.length(); ch++){//chpano更新
											rend[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].range.@end;
											rstart[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].range.@start;
											chid[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].@panoid.split("pano").join("");
											ch_lat[ch] = xml.Panoramas.Panorama.(@panoid == "pano" + chid[ch]).coords.@lat;
											ch_lng[ch] = xml.Panoramas.Panorama.(@panoid == "pano" + chid[ch]).coords.@lng;
										}
										
										panoid = xml.Panoramas.Panorama.(@panoid == id1).@panoid.split("pano").join("");//新しいパノラマ画像の情報を取得
										north = xml.Panoramas.Panorama.(@panoid == id1).direction.@north;
										//snorth=north;
										n_loader.load(new URLRequest("resource/"+ xml.Panoramas.Panorama.(@panoid == id1).img.@src));//新しいパノラマ画像を読み込む
										n_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,texture);//新しいパノラマ画像を貼り付けに
										break;//for文が無駄にまわらないようにbreak
									//}
								}
							}
							else{
								if((rstart[i]<=range && range<360)||(0<=range && range<=rend[i])){//rendが20、rstart350のときとか…たぶんもう少し簡単にできる
									moving = 0;//切替判定中移動禁止
									id1 = "pano"+ chid[i];//ID保存
									//latsa =Math.abs(lat - ch_lat[i]);
									//lngsa =Math.abs(lng - ch_lng[i]);
									
									lat = ch_lat[i];//あとは大体一緒
									lng = ch_lng[i];
									
									//if((latsa <0.000028) &&(lngsa < 0.000028) ){
										
										for(ch=0; ch<xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano.length(); ch++){
											rend[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].range.@end;
											rstart[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].range.@start;
											chid[ch] = xml.Panoramas.Panorama.(@panoid == id1).chpanos.chpano[ch].@panoid.split("pano").join("");
											ch_lat[ch] = xml.Panoramas.Panorama.(@panoid == "pano" + chid[ch]).coords.@lat;
											ch_lng[ch] = xml.Panoramas.Panorama.(@panoid == "pano" + chid[ch]).coords.@lng;
										}
										
										
										panoid = xml.Panoramas.Panorama.(@panoid == id1).@panoid.split("pano").join("");
										north = xml.Panoramas.Panorama.(@panoid == id1).direction.@north;
										//snorth=north;
										n_loader.load(new URLRequest("resource/"+ xml.Panoramas.Panorama.(@panoid == id1).img.@src));
										n_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,texture);
										break;
									//}
								}
							}
						}
					}
					
					
				}
				
				stage.addEventListener(MouseEvent.MOUSE_UP, st_fb_loop);//マウスのドラッグが離れたとき、EnterFrame終了
				function st_fb_loop(e:MouseEvent):void{
					if(al <0){
						forword.alpha = 0.5;
						back.alpha = 0.5;
					}
					removeEventListener(Event.ENTER_FRAME, fb_loop);
					stage.removeEventListener(MouseEvent.MOUSE_UP, st_fb_loop);
					
				}
				
				
					
				
			}
		}
	}
}