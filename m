From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sat, 3 Mar 2007 14:25:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703031424270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net>
 <200703030357.18822.jnareb@gmail.com> <alpine.LRH.0.82.0703022223060.29426@xanadu.home>
 <200703030441.36627.jnareb@gmail.com> <alpine.LRH.0.82.0703022242570.29426@xanadu.home>
 <alpine.LRH.0.82.0703030005320.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Oleg Verych <olecom@flower.upol.cz>,
	Junio C Hamano <junkio@cox.net>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	git@vger.kernel.org, Alp Toker <alp@atoker.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 14:25:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNUEe-0003jw-0T
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 14:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbXCCNZM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 08:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbXCCNZL
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 08:25:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:57181 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030230AbXCCNZK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 08:25:10 -0500
Received: (qmail invoked by alias); 03 Mar 2007 13:25:09 -0000
X-Provags-ID: V01U2FsdGVkX1+BdY9rWFyBPRDT0VxJR1HI0SCv7jQ56wtmiivOry
	KioF0GVWUGhwEE
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LRH.0.82.0703030005320.29426@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41295>

Hi,

On Sat, 3 Mar 2007, Nicolas Pitre wrote:

> On Fri, 2 Mar 2007, Nicolas Pitre wrote:
> 
> > This is Lynx 2.8.5rel.1 (04 Feb 2004) on Fedora Core 6:
> > 
> > $ lynx http://www.kernel.org/git
> > [...]
> > application/xhtml+xml  D)ownload, or C)ancel
> 
> I also tried with elinks and it works fine.
> 
> Then I tried links2 and it gives:
> 
> |?? Unknown type 
> |????????????????????????????????????????????????????????????????
> |
> |Content type is application/xhtml+xml.
> |Do you want to save or display this file?
> |
> |[ Save ]  [ Display ]  [ Cancel ]
> 
> So gitweb is now broken for 2 out of 3 text based browsers that used to 
> just work fine before.

Just to fuel the fire: w3m also wants to download index.html. It also used 
to work fine before. That makes 3 out of 4.

Ciao,
Dscho
