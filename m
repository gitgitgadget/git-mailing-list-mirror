From: Nicolas Pitre <nico@cam.org>
Subject: merry gitmas
Date: Mon, 25 Dec 2006 16:01:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612251549520.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Dec 25 22:01:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gywwk-0001FL-12
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 22:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499AbWLYVBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 16:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbWLYVBE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 16:01:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30272 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbWLYVBD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 16:01:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAU00GIXL1OK3K3@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 25 Dec 2006 16:01:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35395>


Happy holidays to all, and here's a bit of nice programming style to 
inspire you for your git hacking during the Christmas season (yes that 
really compiles and runs):

----- >8

#include <stdio.h>
main(t,_,a)
char *a;
{
return!0<t?t<3?main(-79,-13,a+main(-87,1-_,main(-86,0,a+1)+a)):
1,t<_?main(t+1,_,a):3,main(-94,-27+t,a)&&t==2?_<13?
main(2,_+1,"%s %d %d\n"):9:16:t<0?t<-72?main(_,t,
"@n'+,#'/*{}w+/w#cdnr/+,{}r/*de}+,/*{*+,/w{%+,/w#q#n+,/#{l+,/n{n+,/+#n+,/#\
;#q#n+,/+k#;*+,/'r :'d*'3,}{w+K w'K:'+}e#';dq#'l \
q#'+d'K#!/+k#;q#'r}eKK#}w'r}eKK{nl]'/#;#q#n'){)#}w'){){nl]'/+#n';d}rw' i;# \
){nl]!/n{n#'; r{#w'r nc{nl]'/#{l,+'K {rw' iK{;[{nl]'/w#q#n'wk nw' \
iwk{KK{nl]!/w{%'l##w#' i; :{nl]'/*{q#'ld;r'}{nlwb!/*de}'c \
;;{nl'-{}rw]'/+,}##'*}#nc,',#nw]'/+kd'+e}+;#'rdq#w! nr'/ ') }+}{rl#'{n' \
')# \
}'+}##(!!/")
:t<-50?_==*a?putchar(31[a]):main(-65,_,a+1):main((*a=='/')+t,_,a+1)
:0<t?main(2,2,"%s"):*a=='/'||main(0,main(-61,*a,
"!ek;dc i@bK'(q)-[w]*%n+r3#l,{}:\nuwloca-O;m .vpbks,fxntdCeghiry"),a+1);
}
