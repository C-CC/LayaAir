package laya.ani.bone {
	import laya.ani.bone.Bone;
	import laya.ani.bone.BoneSlot;
	import laya.ani.AnimationPlayer;
	import laya.ani.GraphicsAni;
	import laya.display.Sprite;
	import laya.utils.Handler;
	import laya.resource.Texture;
	import laya.ani.bone.Templet;

	/*
	 * 动画开始播放调度
	 * @eventType Event.PLAYED
	 */

	/*
	 * 动画停止播放调度
	 * @eventType Event.STOPPED
	 */

	/*
	 * 动画暂停播放调度
	 * @eventType Event.PAUSED
	 */

	/*
	 * 自定义事件。
	 * @eventType Event.LABEL
	 */

	/*
	 * 骨骼动画由<code>Templet</code>，<code>AnimationPlayer</code>，<code>Skeleton</code>三部分组成。
	 */
	public class Skeleton extends laya.display.Sprite {

		/*
		 * 在canvas模式是否使用简化版的mesh绘制，简化版的mesh将不进行三角形绘制，而改为矩形绘制，能极大提高性能，但是可能某些mesh动画效果会不太正常
		 */
		public static var useSimpleMeshInCanvas:Boolean;
		protected var _templet:Templet;

		/*
		 * @private 
		 */
		protected var _player:AnimationPlayer;

		/*
		 * @private 
		 */
		protected var _curOriginalData:Float32Array;
		private var _boneMatrixArray:*;
		private var _lastTime:*;
		private var _currAniIndex:*;
		private var _pause:*;

		/*
		 * @private 
		 */
		protected var _aniClipIndex:Number;

		/*
		 * @private 
		 */
		protected var _clipIndex:Number;
		private var _skinIndex:*;
		private var _skinName:*;
		private var _aniMode:*;
		private var _graphicsCache:*;
		private var _boneSlotDic:*;
		private var _bindBoneBoneSlotDic:*;
		private var _boneSlotArray:*;
		private var _index:*;
		private var _total:*;
		private var _indexControl:*;
		private var _aniPath:*;
		private var _complete:*;
		private var _loadAniMode:*;
		private var _yReverseMatrix:*;
		private var _ikArr:*;
		private var _tfArr:*;
		private var _pathDic:*;
		private var _rootBone:*;

		/*
		 * @private 
		 */
		protected var _boneList:Array;

		/*
		 * @private 
		 */
		protected var _aniSectionDic:*;
		private var _eventIndex:*;
		private var _drawOrderIndex:*;
		private var _drawOrder:*;
		private var _lastAniClipIndex:*;
		private var _lastUpdateAniClipIndex:*;
		private var _playAudio:*;
		private var _soundChannelArr:*;

		/*
		 * 创建一个Skeleton对象
		 * @param templet 骨骼动画模板
		 * @param aniMode 动画模式，0不支持换装，1、2支持换装
		 */

		public function Skeleton(templet:Templet = undefined,aniMode:Number = undefined){}

		/*
		 * 初始化动画
		 * @param templet 模板
		 * @param aniMode 动画模式
		 */
		public function init(templet:Templet,aniMode:Number = null):void{}

		/*
		 * 得到资源的URL
		 */

		/*
		 * 设置动画路径
		 */
		public var url:String;

		/*
		 * 通过加载直接创建动画
		 * @param path 要加载的动画文件路径
		 * @param complete 加载完成的回调函数
		 * @param aniMode 与<code>Skeleton.init</code>的<code>aniMode</code>作用一致
		 */
		public function load(path:String,complete:Handler = null,aniMode:Number = null):void{}

		/*
		 * 加载完成
		 */
		private var _onLoaded:*;

		/*
		 * 解析完成
		 */
		private var _parseComplete:*;

		/*
		 * 解析失败
		 */
		private var _parseFail:*;

		/*
		 * 传递PLAY事件
		 */
		private var _onPlay:*;

		/*
		 * 传递STOP事件
		 */
		private var _onStop:*;

		/*
		 * 传递PAUSE事件
		 */
		private var _onPause:*;

		/*
		 * 创建骨骼的矩阵，保存每次计算的最终结果
		 */
		private var _parseSrcBoneMatrix:*;
		private var _emitMissedEvents:*;

		/*
		 * 更新动画
		 * @param autoKey true为正常更新，false为index手动更新
		 */
		private var _update:*;

		/*
		 * @private 清掉播放完成的音频
		 * @param force 是否强制删掉所有的声音channel
		 */
		private var _onAniSoundStoped:*;

		/*
		 * @private 创建grahics图像. 并且保存到cache中
		 * @param _clipIndex 第几帧
		 */
		protected function _createGraphics(_clipIndex:Number = null):GraphicsAni{
			return null;
		}
		private var _checkIsAllParsed:*;

		/*
		 * 设置deform数据
		 * @param tDeformAniData 
		 * @param tDeformDic 
		 * @param _boneSlotArray 
		 * @param curTime 
		 */
		private var _setDeform:*;

		/*
		 * *****************************************定义接口************************************************
		 */

		/*
		 * 得到当前动画的数量
		 * @return 当前动画的数量
		 */
		public function getAnimNum():Number{
			return null;
		}

		/*
		 * 得到指定动画的名字
		 * @param index 动画的索引
		 */
		public function getAniNameByIndex(index:Number):String{
			return null;
		}

		/*
		 * 通过名字得到插槽的引用
		 * @param name 动画的名字
		 * @return 插槽的引用
		 */
		public function getSlotByName(name:String):BoneSlot{
			return null;
		}

		/*
		 * 通过名字显示一套皮肤
		 * @param name 皮肤的名字
		 * @param freshSlotIndex 是否将插槽纹理重置到初始化状态
		 */
		public function showSkinByName(name:String,freshSlotIndex:Boolean = null):void{}

		/*
		 * 通过索引显示一套皮肤
		 * @param skinIndex 皮肤索引
		 * @param freshSlotIndex 是否将插槽纹理重置到初始化状态
		 */
		public function showSkinByIndex(skinIndex:Number,freshSlotIndex:Boolean = null):void{}

		/*
		 * 设置某插槽的皮肤
		 * @param slotName 插槽名称
		 * @param index 插糟皮肤的索引
		 */
		public function showSlotSkinByIndex(slotName:String,index:Number):void{}

		/*
		 * 设置某插槽的皮肤
		 * @param slotName 插槽名称
		 * @param name 皮肤名称
		 */
		public function showSlotSkinByName(slotName:String,name:String):void{}

		/*
		 * 替换插槽贴图名
		 * @param slotName 插槽名称
		 * @param oldName 要替换的贴图名
		 * @param newName 替换后的贴图名
		 */
		public function replaceSlotSkinName(slotName:String,oldName:String,newName:String):void{}

		/*
		 * 替换插槽的贴图索引
		 * @param slotName 插槽名称
		 * @param oldIndex 要替换的索引
		 * @param newIndex 替换后的索引
		 */
		public function replaceSlotSkinByIndex(slotName:String,oldIndex:Number,newIndex:Number):void{}

		/*
		 * 设置自定义皮肤
		 * @param name 插糟的名字
		 * @param texture 自定义的纹理
		 */
		public function setSlotSkin(slotName:String,texture:Texture):void{}

		/*
		 * 换装的时候，需要清一下缓冲区
		 */
		private var _clearCache:*;

		/*
		 * 播放动画
		 * @param nameOrIndex 动画名字或者索引
		 * @param loop 是否循环播放
		 * @param force false,如果要播的动画跟上一个相同就不生效,true,强制生效
		 * @param start 起始时间
		 * @param end 结束时间
		 * @param freshSkin 是否刷新皮肤数据
		 * @param playAudio 是否播放音频
		 */
		public function play(nameOrIndex:*,loop:Boolean,force:Boolean = null,start:Number = null,end:Number = null,freshSkin:Boolean = null,playAudio:Boolean = null):void{}

		/*
		 * 停止动画
		 */
		public function stop():void{}

		/*
		 * 设置动画播放速率
		 * @param value 1为标准速率
		 */
		public function playbackRate(value:Number):void{}

		/*
		 * 暂停动画的播放
		 */
		public function paused():void{}

		/*
		 * 恢复动画的播放
		 */
		public function resume():void{}

		/*
		 * @private 得到缓冲数据
		 * @param aniIndex 
		 * @param frameIndex 
		 * @return 
		 */
		private var _getGrahicsDataWithCache:*;

		/*
		 * @private 保存缓冲grahpics
		 * @param aniIndex 
		 * @param frameIndex 
		 * @param graphics 
		 */
		private var _setGrahicsDataWithCache:*;

		/*
		 * 销毁当前动画
		 * @override 
		 */
		override public function destroy(destroyChild:Boolean = null):void{}

		/*
		 * @private 得到帧索引
		 */

		/*
		 * @private 设置帧索引
		 */
		public var index:Number;

		/*
		 * 得到总帧数据
		 */
		public function get total():Number{
				return null;
		}

		/*
		 * 得到播放器的引用
		 */
		public function get player():AnimationPlayer{
				return null;
		}

		/*
		 * 得到动画模板的引用
		 * @return templet.
		 */
		public function get templet():Templet{
				return null;
		}
	}

}