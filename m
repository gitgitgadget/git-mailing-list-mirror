From: Nicolas Pitre <nico@cam.org>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Fri, 02 Mar 2007 22:49:29 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0703022242570.29426@xanadu.home>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net>
 <200703030357.18822.jnareb@gmail.com>
 <alpine.LRH.0.82.0703022223060.29426@xanadu.home>
 <200703030441.36627.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Oleg Verych <olecom@flower.upol.cz>,
	Junio C Hamano <junkio@cox.net>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	git@vger.kernel.org, Alp Toker <alp@atoker.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 04:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNLFh-0004KR-Co
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 04:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992936AbXCCDtb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 22:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992937AbXCCDtb
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 22:49:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45212 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992936AbXCCDta (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 22:49:30 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JEB00H626MHT2M0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 02 Mar 2007 22:49:29 -0500 (EST)
In-reply-to: <200703030441.36627.jnareb@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41270>

On Sat, 3 Mar 2007, Jakub Narebski wrote:

> Nicolas Pitre wrote:
> > On Sat, 3 Mar 2007, Jakub Narebski wrote:
> > 
> >> By "conservatively" it means that it uses 'application/xhtml+xml' only when
> >> client explicitly claims that it accepts its, and it is not due to for
> >> example */* accept globbing.
> >> 
> >> So if lynx isn't working, it is its damn fault...
> > 
> > I absolutely don't care.
> > 
> > I use lynx, and lynx worked perfectly fine before.  So it is not lynx 
> > that broke it.  Please fix gitweb.
> 
> WORKSFORME.
> 
> Lynx Version 2.8.5rel.1 (04 Feb 2004)
> libwww-FM 2.14, SSL-MM 1.4.1, OpenSSL 0.9.7f
> 
> git web interface version 1.5.0.rc3.gc0bbd
> 
> (and application/xhtml+xml is _not_ among Accept's).

This is Lynx 2.8.5rel.1 (04 Feb 2004) on Fedora Core 6:

$ lynx http://www.kernel.org/git
[...]
application/xhtml+xml  D)ownload, or C)ancel


Nicolas
