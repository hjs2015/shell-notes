BEGIN	{
	FS=":"
	line=0
	field=0
}
	NF>5 && NF<8 && NR%2==1 {
	line=line+1
	field=field+NF
}
END	{
	print "符合的总行数为:"line"\n符合的总列数为:"field
}
