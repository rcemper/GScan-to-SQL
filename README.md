 ~~~
 This is a coding example working on IRIS 2020.1 and on Caché 2018.1.3 
 It will not be kept in sync with new versions      
 It is also NOT serviced by InterSystems Support !   
~~~ 

In most cases, a global used by default storage has just 1 subscript level that     
represents the IDKEY.  For an index-globals we may see 2 or more subscript levels.     
Arrays, or parent-child relationships or persistent classes extending a base data class   
are examples where we see more levels. Though all these globals are quite uniform.  

And then we see globals not related to classes or tables like ^SPOOL,   
or ^ERRORS, or ^%SYS where the structure depends on various levels  
of subscripts with special meaning. 

Analysis of those non-conform globals is a challenge and just dumping  
it doesn't necessarily help to understand the dependencies.    

This example is oriented at the old joke:   
"How do you eat an elephant?" ==> "cut in thin slices !" 
  
That's the offer: By an SQL statement you can display the stucture    
of any global level by level. You provide global name and the maximum level    
and get back the related subscripts, $Data of the node teh number of   
next subnodes and - if avaiable - the content stored at that level.  

example: 
__SELECT * FROM rcc_G.scan where rcc_G.Scan('^%SYS',1)=1__

~~~
Reference       Level	$D SubNodes Value
^%SYS               0	10 25	 
("CSP")             1	10	 	 
("CSPAppSec")       1	1    64
("CacheTempDir")    1	1   "c:\intersystems\iris\mgr\iristemp\"
("DBRefByName")     1	10	 	 
("Ensemble")        1	11  "2020-04-25 18:37:18"
("ErrorPurge")      1	1    30
("FIPSMode")        1	1    0
("IRISTempDir")     1	1    c:\intersystems\iris\mgr\iristemp\"
("JOURNAL")         1	11   0
("LANGUAGE")        1	10	 	 
("LASTSESSIONGUID") 1	1   "EÊcRù¢GM£ô"_$c(127)_"¹9¾ÒÆ"
("LOCALE")          1	10	 	 
("ModuleRoot")      1	10	 	 
("NLS")             1	10	 	 
("SERVICE")         1	10	 	 
("SSPort")          1	1    51773
("StreamLocation")  1	10	 	 
("SystemMode")      1	1   "TEST"
("TempDir")         1	1   "C:\InterSystems\IRIS\mgr\Temp"
("WebServer")       1	10	 	 
("bindir")          1	1   "c:\intersystems\iris\bin\"
("shutdownlogerrors") 1 1 0
("sql")             1	10	 	 
("sysdir")          1	1   "c:\intersystems\iris\mgr\"
("tercap")          1	10	 	 
26 lines
~~~

__SELECT * FROM rcc_G.scan where rcc_G.Scan('^%SYS',2)=1__
~~~
Reference                   Level	$D SubN     Value
^%SYS                           0	10 25  
("CSP")                         1	10 1  
("CSP","LastUpdate")            2	1     "65553,44452"
("CSPAppSec")                   1	1  0  64
("CacheTempDir")                1	1  0  "c:\intersystems\iris\mgr\iristemp\"
("DBRefByName")                 1	10 9 	 
("DBRefByName","CACHE")         2	1     "^^c:\intersystems\iris\mgr\cache\"
("DBRefByName","CACHEUSER")     2	1     "^^c:\intersystems\user\"
("DBRefByName","ENSLIB")        2	1     "^^c:\intersystems\iris\mgr\enslib\"
("DBRefByName","IRISAUDIT")     2	1     "^^c:\intersystems\iris\mgr\irisaudit\"
("DBRefByName","IRISLIB")       2	1     "^^c:\intersystems\iris\mgr\irislib\"
("DBRefByName","IRISLOCALDATA") 2	1     "^^c:\intersystems\iris\mgr\irislocaldata\"
   < 60 lines more >
~~~
__SELECT * FROM rcc_G.scan where rcc_G.Scan('^ERRORS',37)=1 and id\['Jour'__
~~~
Reference                                            Level	$D	SubNodes	Value
(65588,1,"*STACK",1,"V","%00000","N","""JournalState""")	8	1	 0	       4
(65592,1,"*STACK",1,"V","%00000","N","""JournalState""")	8	1	 0	       4
(65592,2,"*STACK",1,"V","%00000","N","""JournalState""")	8	1	 0	       4
~~~

[Article in DC](https://community.intersystems.com/post/golbal-scanning-slicing)
