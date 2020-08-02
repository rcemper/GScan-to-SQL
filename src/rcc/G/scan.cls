Class rcc.G.scan Extends %Persistent [ Final, SqlRowIdPrivate ]
{

Property Reference As %String(COLLATION = "EXACT", MAXLEN = "") [ ReadOnly, Required, SqlColumnNumber = 2 ];

Property Level As %Integer [ ReadOnly, SqlColumnNumber = 3 ];

Property DData As %Integer [ ReadOnly, SqlColumnNumber = 4, SqlFieldName = "$Data" ];

Property SubNodes As %Integer [ ReadOnly, SqlColumnNumber = 5 ];

Property Value As %String [ ReadOnly, SqlColumnNumber = 6 ];

Index id On Reference [ IdKey ];

/// fill PPG
ClassMethod Scan(Global As %String = "", LevelLimit As %Integer = 1) As %Boolean [ SqlName = Scan, SqlProc ]
{
	kill ^||G.scanD
	set def=$d(@Global,val)
		,(ct,lev)=0
		,glob=Global_"()"
	if def>1 set ct=..sub(.glob,lev,.LevelLimit)
	set data=$lb(lev,def,ct)
	if def#10 set data=data_$lb(..val(val))
	set ^||G.scanD(" "_Global)=data
	quit $$$OK
}

ClassMethod sub(ByRef glob, lev, ByRef Limit) As %Integer
{
	if $I(lev),lev>Limit quit ""
	set subs=""""""
	for loop=0:1 {
		set g=$replace(glob,")",subs_")")
		set subs=$o(@g) quit:subs=""
		if '$isvalidnum(subs),$e(subs)'=""""  set subs=""""_subs_""""
		set def=$d(@$zr,val)
		set zr="("_$p($zr,"(",2,999)
		set next=$replace($zr,")",",)")
		set ct=..sub(next, lev,.Limit)
		set data=$lb(lev,def,ct)
		if def#10 set data=data_$lb(..val(val))
		set ^||G.scanD(zr)=data
		}  
	quit loop
}

ClassMethod val(val) As %String
{
	kill ^SPOOL(999999) open 2:999999 use 2 zw val close 2 	
	set val=$e(^SPOOL(999999,1),5,*-2) kill ^SPOOL(999999)
	set val=$replace($replace(val,$c(27)_"[1m",""),$c(27)_"[22m","")	
	quit val
}

Storage Default
{
<Data name="dumpDefaultData">
<Value name="1">
<Value>Level</Value>
</Value>
<Value name="2">
<Value>DData</Value>
</Value>
<Value name="3">
<Value>SubNodes</Value>
</Value>
<Value name="4">
<Value>Value</Value>
</Value>
</Data>
<DataLocation>^||G.scanD</DataLocation>
<DefaultData>dumpDefaultData</DefaultData>
<IdLocation>^||G.scanD</IdLocation>
<IndexLocation>^||G.scanI</IndexLocation>
<StreamLocation>^||G.scanS</StreamLocation>
<Type>%Storage.Persistent</Type>
}
