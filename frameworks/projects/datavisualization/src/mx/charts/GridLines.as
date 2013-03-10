////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2003-2006 Adobe Macromedia Software LLC and its licensors.
//  All Rights Reserved. The following is Source Code and is subject to all
//  restrictions on such code as contained in the End User License Agreement
//  accompanying this product.
//
////////////////////////////////////////////////////////////////////////////////

package mx.charts
{

import flash.display.Graphics;
import flash.geom.Rectangle;
import mx.charts.chartClasses.CartesianChart;
import mx.charts.chartClasses.ChartElement;
import mx.charts.chartClasses.ChartState;
import mx.charts.chartClasses.GraphicsUtilities;
import mx.charts.chartClasses.IAxisRenderer;
import mx.charts.styles.HaloDefaults;
import mx.core.mx_internal;
import mx.graphics.IFill;
import mx.graphics.IStroke;
import mx.graphics.Stroke;
import mx.styles.CSSStyleDeclaration;

use namespace mx_internal;

//--------------------------------------
//  Styles
//--------------------------------------

/**
 *  Specifies the direction of the grid lines.
 *  Allowable values are <code>horizontal</code>,
 *  <code>vertical</code>, or <code>both</code>. 
 *  The default value is <code>horizontal</code>.  
 */
[Style(name="direction", type="String", enumeration="horizontal,vertical,both", inherit="no")]

/**
 *  Specifies the fill pattern for alternating horizontal bands
 *  not defined by the <code>fill</code> property.
 *  Use the IFill class to define the properties of the fill
 *  as a child tag in MXML, or create an IFill object in ActionScript.  
 *  Set to <code>null</code> to not fill the bands.
 *  The default value is <code>null</code>.
 */
[Style(name="horizontalAlternateFill", type="mx.graphics.IFill", inherit="no")]

/**
 *  Specifies the number of tick marks between horizontal grid lines.
 *  Set the <code>horizontalChangeCount</code> property to 3
 *  to draw a grid line at every third tick mark along the axis. 
 *  The fill style alternates at each grid line, so a larger
 *  <code>horizontalChangeCount</code> value results
 *  in large alternating bands. 
 *  The defaults value is <code>1</code>. 
 */
[Style(name="horizontalChangeCount", type="int", inherit="no")]

/**
 *  Specifies the fill pattern for every other horizontal band
 *  created by the grid lines.
 *  Use the IFill class to define the  properties of the fill
 *  as a child tag in MXML, or create a IFill object in ActionScript.  
 *  Set to <code>null</code> to not fill the bands.
 *  The default value is <code>null</code>.
 */
[Style(name="horizontalFill", type="mx.graphics.IFill", inherit="no")]

/**
 *  Specifies the line style for the horizontal origin.
 *  Use the Stroke class to define the properties as a child tag in MXML,
 *  or create a Stroke object in ActionScript.  
 */
[Style(name="horizontalOriginStroke", type="mx.graphics.IStroke", inherit="no")]

/**
 *  Determines whether to draw the horizontal origin.
 *  If <code>true</code>, and the origin falls within the chart bounds,
 *  the grid lines draw it using the <code>horizontalOriginStroke</code> style.
 *  For ColumnChart, LineChart, PlotChart, BubbleChart, and AreaChart
 *  controls, the default value is <code>true</code>.
 *  For BarChart controls, the default value is <code>false</code>.
 *  This property does not apply to PieChart controls.
 */
[Style(name="horizontalShowOrigin", type="Boolean", inherit="no")]

/**
 *  Specifies the line style for horizontal grid lines.
 *  Use the Stroke class to define the properties as a child tag in MXML,
 *  or create a Stroke object in ActionScript.  
 */
[Style(name="horizontalStroke", type="mx.graphics.IStroke", inherit="no")]

/**
 *  Determines whether to align horizontal grid lines with tick marks.
 *  If <code>true</code>, horizontal grid lines are drawn aligned
 *  with the tick marks.
 *  If <code>false</code>, Flex draws them between tick marks.
 *  The default value is <code>true</code>.
 */
[Style(name="horizontalTickAligned", type="Boolean", inherit="no")]

/**
 *  Specifies the fill pattern for alternating vertical bands
 *  not defined by the fill property.
 *  Use the IFill class to define the properties of the fill
 *  as a child tag in MXML, or create an IFill object in ActionScript.  
 *  Set to <code>null</code> to not fill the bands.
 *  The default value is <code>null</code>.
 */
[Style(name="verticalAlternateFill", type="mx.graphics.IFill", inherit="no")]

/**
 *  Specifies the number of tick marks between vertical grid lines.
 *  Set <code>verticalChangeCount</code> to <code>3</code>
 *  to draw a grid line at every third tick mark along the axis. 
 *  The fill style alternates at each grid line, so a larger
 *  <code>verticalChangeCount</code> value results in large alternating bands. 
 *  The default value is <code>1</code>. 
 */
[Style(name="verticalChangeCount", type="int", inherit="no")]

/**
 *  Specifies the fill pattern for alternating vertical bands
 *  created by the grid lines.
 *  Use the IFill class to define the properties of the fill
 *  as a child tag in MXML, or create a IFill object in ActionScript.  
 *  Set to <code>null</code> to not fill the bands.
 *  The default value is <code>null</code>.
 */
[Style(name="verticalFill", type="mx.graphics.IFill", inherit="no")]

/**
 *  Specifies the line style for the vertical origin.
 *  Use the Stroke class to define the properties as a child tag in MXML,
 *  or create a Stroke object in ActionScript.  
 */
[Style(name="verticalOriginStroke", type="mx.graphics.IStroke", inherit="no")]

/**
 *  Determines whether to draw the vertical Origin.
 *  If <code>true</code>, and the origin falls within the chart bounds,
 *  Flex draws it using the <code>verticalOriginStroke</code> style.
 *  For ColumnChart, LineChart, and AreaChart controls,
 *  the default value is <code>false</code>.
 *  For PlotChart, BubbleChart, and BarChart controls,
 *  the default value is <code>true</code>.
 *  This property does not apply to PieChart controls.
 */
[Style(name="verticalShowOrigin", type="Boolean", inherit="no")]

/**
 *  Specifies the line style for vertical grid lines.
 *  Use the Stroke class to define the properties as a child tag in MXML,
 *  or create a Stroke object in ActionScript.  
 */
[Style(name="verticalStroke", type="mx.graphics.IStroke", inherit="no")]

/**
 *  Determines whether to align vertical grid lines with tick marks.
 *  If <code>true</code>, Flex draws vertical grid lines aligned
 *  with the tick marks.
 *  If <code>false</code>, Flex draws them between tick marks.
 *  The default value is <code>true</code>.
 */
[Style(name="verticalTickAligned", type="Boolean", inherit="no")]

/** 
 *  The GridLines class draws grid lines inside the data area of the chart.
 *  Flex can draw lines horizontally, vertically, or both. 
 *  
 *  <p>Flex draws grid lines aligned to the tick marks of the parent chart.
 *  By default, Flex draws one line for every tick mark
 *  along the appropriate axis.</p>
 *  
 *  <p>You typically use the GridLines class as a child tag
 *  of a chart control's <code>backgroundElements</code> property
 *  or <code>annotationElements</code> property.</p>
 *  
 *  @mxml
 *  
 *  <p>The <code>&lt;mx:GridLines&gt;</code> tag inherits all the properties
 *  of its parent classes and adds the following properties:</p>
 *  
 *  <pre>
 *  &lt;mx:GridLines
 *    <strong>Styles</strong>
 *     direction="horizontal|vertical|both"
 *     horizontalAlternateFill="null"
 *     horizontalChangeCount="1"
 *     horizontalFill="null"
 *     horizontalOriginStroke="<i>IStroke; No default</i>"
 *     horizontalShowOrigin="<i>Default depends on type of chart</i>"
 *     horizontalStroke="<i>IStroke; No default</i>"
 *     horizontalTickAligned="true|false"
 *     verticalAlternateFill="null"
 *     verticalChangeCount="1"
 *     verticalFill="null"
 *     verticalOriginStroke="<i>IStroke; No default</i>"
 *     verticalShowOrigin="<i>Default depends on type of chart</i>"
 *     verticalStroke="<i>IStroke; No default</i>"
 *     verticalTickAligned="true|false"
 *  /&gt;
 *  </pre>
 *
 *  @includeExample examples/GridLinesExample.mxml
 */
public class GridLines extends ChartElement
{
    include "../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Class initialization
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	private static var stylesInited:Boolean = initStyles();	
	
	/**
	 *  @private
	 */
	private static function initStyles():Boolean
	{
		HaloDefaults.init();

		var gridlinesStyleName:CSSStyleDeclaration =
			HaloDefaults.createSelector("GridLines");

		gridlinesStyleName.defaultFactory = function():void
		{
			this.direction = "horizontal";
			this.horizontalOriginStroke = new Stroke(0xB0C1D0, 1);
			this.horizontalShowOrigin = true;
			this.horizontalStroke = new Stroke(0xEEEEEE, 0);
			this.horizontalTickAligned = true;
			this.verticalOriginStroke = new Stroke(0xB0C1D0, 1);
			this.verticalShowOrigin = false;
			this.verticalStroke = new Stroke(0xEEEEEE, 0);
			this.verticalTickAligned= true;
		}

		var hgridlinesStyle:CSSStyleDeclaration =
			HaloDefaults.createSelector(".horizontalGridLines");

		hgridlinesStyle.defaultFactory = function():void
		{
			this.direction = "vertical";
			this.horizontalFill = null;
			this.horizontalShowOrigin = false;
			this.horizontalTickAligned = true;
			this.verticalFill = null;
			this.verticalShowOrigin = true;
			this.verticalTickAligned= true;
		}

		var bothGridLines:CSSStyleDeclaration =
			HaloDefaults.createSelector(".bothGridLines");

		bothGridLines.defaultFactory = function():void
		{
			this.direction = "both";
			this.horizontalShowOrigin = true;
			this.horizontalTickAligned= true;
			this.verticalShowOrigin = true;
			this.verticalTickAligned= true;
		}

		return true;
	}

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  Constructor.
	 */
	public function GridLines()
	{
		super();
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods: UIComponent
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	override protected function updateDisplayList(unscaledWidth:Number,
												  unscaledHeight:Number):void
	{
		super.updateDisplayList(unscaledWidth, unscaledHeight);

		var len:int;
		var c:Object;
		var stroke:IStroke;
		var changeCount:int;
		var ticks:Array /* of Number */;
		var spacing:Array /* of Number */;
		var axisLength:Number;
		var colors:Array /* of IFill */;
		var rc:Rectangle;
		var originStroke:IStroke;
		var addedFirstLine:Boolean;
		var addedLastLine:Boolean;
		
		if (!chart||
			chart.chartState == ChartState.PREPARING_TO_HIDE_DATA ||
			chart.chartState == ChartState.HIDING_DATA)
		{
			return;
		}
		
		var g:Graphics = graphics;
		g.clear();
		
		var direction:String = getStyle("direction");
		if (direction == "horizontal" || direction == "both")
		{
			stroke = getStyle("horizontalStroke");
			
			changeCount = Math.max(1, getStyle("horizontalChangeCount"));
			if ((changeCount * 0 != 0) || changeCount <= 1)
				changeCount = 1;

			var verticalAxisRenderer:IAxisRenderer;
			
			if(!(CartesianChart(chart).verticalAxisRenderer))
			{
				verticalAxisRenderer = CartesianChart(chart).getLeftMostRenderer();
				if(!verticalAxisRenderer)
					verticalAxisRenderer = CartesianChart(chart).getRightMostRenderer();
			}
			else
			    verticalAxisRenderer = CartesianChart(chart).verticalAxisRenderer;

			ticks = verticalAxisRenderer.ticks;

			if (getStyle("horizontalTickAligned") == false)
			{
				len = ticks.length;
				spacing = [];
				for (var i:int = 1; i < len; i++)
				{
					spacing[i - 1] = (ticks[i] + ticks[i - 1]) / 2;
				}
			}
			else
			{
				spacing = ticks;
			}
					
			addedFirstLine = false;
			addedLastLine = false;

			if (spacing[0] != 0)
			{
				addedFirstLine = true;
				spacing.unshift(0);
			}

			if (spacing[spacing.length - 1] != 1)
			{
				addedLastLine = true;
				spacing.push(1);
			}

			axisLength = unscaledHeight;
						
			colors = [ getStyle("horizontalFill"),
					   getStyle("horizontalAlternateFill") ];

			len = spacing.length;
			
			if (spacing[len - 1] < 1)
			{
				c = colors[1];
				if (c != null)
				{
					g.lineStyle(0, 0, 0);
					GraphicsUtilities.fillRect(g, 0, 
						spacing[len - 1] * axisLength, unscaledWidth,
						unscaledHeight, c);
				}
			}

			for (i = 0; i < spacing.length; i += changeCount)
			{
				var idx:int = len - 1 - i;
				c = colors[(i / changeCount) % 2];
				var bottom:Number = spacing[idx] * axisLength;
				var top:Number =
					spacing[Math.max(0, idx - changeCount)] * axisLength;
				rc = new Rectangle(0, top, unscaledWidth, bottom-top);

				if (c != null)
				{
					g.lineStyle(0, 0, 0);
					GraphicsUtilities.fillRect(g, rc.left, rc.top,
											   rc.right, rc.bottom, c);
				}
				
				if (stroke && rc.bottom >= -1) //round off errors
				{
					if (addedFirstLine && idx == 0)
						continue;
					if (addedLastLine && idx == (spacing.length-1))
						continue;

					stroke.apply(g);
					g.moveTo(rc.left, rc.bottom);
					g.lineTo(rc.right, rc.bottom);

				}
			}
		}

		if (direction == "vertical" || direction == "both")
		{
			
			stroke = getStyle("verticalStroke");
			changeCount = Math.max(1,getStyle("verticalChangeCount"));
			
			if (isNaN(changeCount) || changeCount <= 1)
				changeCount = 1;

			var horizontalAxisRenderer:IAxisRenderer;
			
			if(!(CartesianChart(chart).horizontalAxisRenderer))
			{
				horizontalAxisRenderer = CartesianChart(chart).getBottomMostRenderer();
				if(!horizontalAxisRenderer)
					horizontalAxisRenderer = CartesianChart(chart).getTopMostRenderer();
			}
			else
			    horizontalAxisRenderer = CartesianChart(chart).horizontalAxisRenderer;
			
			ticks = horizontalAxisRenderer.ticks.concat();

			if (getStyle("verticalTickAligned") == false)
			{
				len = ticks.length;
				spacing = [];
				for (i = 1; i < len; i++)
				{
					spacing[i - 1] = (ticks[i] + ticks[i - 1]) / 2;
				}
			}
			else
			{
				spacing = ticks;
			}

			addedFirstLine = false;
			addedLastLine = false;
			
			if (spacing[0] != 0)
			{
				addedFirstLine = true;
				spacing.unshift(0);
			}

			if (spacing[spacing.length - 1] != 1)
			{
				addedLastLine = true;
				spacing.push(1);
			}
				
			axisLength = unscaledWidth;
							
			colors = [ getStyle("verticalFill"),
					   getStyle("verticalAlternateFill") ];

			for (i = 0; i < spacing.length; i += changeCount)
			{
				c = colors[(i / changeCount) % 2];
				var left:Number = spacing[i] * axisLength;
				var right:Number =
					spacing[Math.min(spacing.length - 1,
									 i + changeCount)] * axisLength;
				rc = new Rectangle(left, 0, right - left, unscaledHeight);
				if (c != null)
				{
					g.lineStyle(0, 0, 0);
					GraphicsUtilities.fillRect(g, rc.left, rc.top,
											   rc.right, rc.bottom, c);
				}

				if (stroke) // round off errors
				{
					if (addedFirstLine && i == 0)
						continue;
					if (addedLastLine && i == spacing.length-1)
						continue;
						
					stroke.apply(g);
					g.moveTo(rc.left, rc.top);
					g.lineTo(rc.left, rc.bottom);
				}
			}
		}

		var horizontalShowOrigin:Object = getStyle("horizontalShowOrigin");
		var verticalShowOrigin:Object = getStyle("verticalShowOrigin");

		if (verticalShowOrigin || horizontalShowOrigin)
		{
			var cache:Array /* of Object */ = [ { xOrigin: 0, yOrigin: 0 } ];
			var sWidth:Number = 0.5;

			dataTransform.transformCache(cache, "xOrigin", "x", "yOrigin", "y");

			if (horizontalShowOrigin &&
				cache[0].y > 0 && cache[0].y < unscaledHeight)
			{
				originStroke = getStyle("horizontalOriginStroke");
				originStroke.apply(g);
				g.moveTo(0, cache[0].y - sWidth / 2);
				g.lineTo($width, cache[0].y - sWidth / 2);
			}

			if (verticalShowOrigin &&
				cache[0].x > 0 && cache[0].x < unscaledWidth)
			{
				originStroke = getStyle("verticalOriginStroke");
				originStroke.apply(g);
				g.moveTo(cache[0].x - sWidth / 2, 0);
				g.lineTo(cache[0].x - sWidth / 2, $height);
			}
		}
	}

	//--------------------------------------------------------------------------
	//
	//  Overridden methods: ChartElement
	//
	//--------------------------------------------------------------------------

	/**
	 *  @private
	 */
	override public function mappingChanged():void
	{
		invalidateDisplayList();
	}
	
	/**
	 *  @private
	 */
	override public function chartStateChanged(oldState:uint,
											   newState:uint):void
	{
		invalidateDisplayList();
	}
}

}