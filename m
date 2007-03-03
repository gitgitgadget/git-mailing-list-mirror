From: Nicolas Pitre <nico@cam.org>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sat, 03 Mar 2007 00:09:02 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0703030005320.29426@xanadu.home>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net>
 <200703030357.18822.jnareb@gmail.com>
 <alpine.LRH.0.82.0703022223060.29426@xanadu.home>
 <200703030441.36627.jnareb@gmail.com>
 <alpine.LRH.0.82.0703022242570.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Oleg Verych <olecom@flower.upol.cz>,
	Junio C Hamano <junkio@cox.net>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	git@vger.kernel.org, Alp Toker <alp@atoker.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 06:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNMUj-0001OD-CM
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 06:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbXCCFJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 00:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbXCCFJE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 00:09:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54486 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321AbXCCFJD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 00:09:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JEB0058YAB2VVG0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Mar 2007 00:09:02 -0500 (EST)
In-reply-to: <alpine.LRH.0.82.0703022242570.29426@xanadu.home>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41273>

On Fri, 2 Mar 2007, Nicolas Pitre wrote:

> This is Lynx 2.8.5rel.1 (04 Feb 2004) on Fedora Core 6:
> 
> $ lynx http://www.kernel.org/git
> [...]
> application/xhtml+xml  D)ownload, or C)ancel

I also tried with elinks and it works fine.

Then I tried links2 and it gives:

|?? Unknown type 
|????????????????????????????????????????????????????????????????
|
|Content type is application/xhtml+xml.
|Do you want to save or display this file?
|
|[ Save ]  [ Display ]  [ Cancel ]

So gitweb is now broken for 2 out of 3 text based browsers that used to 
just work fine before.


Nicolas
