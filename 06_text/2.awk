BEGIN	{
	FS=":"
	sum=0
}
	 {
	if (NF>7)
	sum=sum+1
}
END	{
	print sum
}
