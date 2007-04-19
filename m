From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Thu, 19 Apr 2007 10:19:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704191019100.8822@racer.site>
References: <200704171041.46176.andyparkins@gmail.com> <"200704171803.58940.a
 n dyparkins"@gmail.com> <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home> <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704172154160.4504@xanadu.home> <Pine.LNX.4.64.0704181313060.12094@racer.site>
 <alpine.LFD.0.98.0704181058190.4504@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 10:20:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeRst-0003mH-1g
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 10:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbXDSIUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 04:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbXDSIUZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 04:20:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:50636 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161224AbXDSIUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 04:20:00 -0400
Received: (qmail invoked by alias); 19 Apr 2007 08:19:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 19 Apr 2007 10:19:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18x+R8eZe4xpZL+k0FH2pcSirxsvM8HDMoHhGO31y
	jDGV5Cg335aCV/
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0704181058190.4504@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44990>

Hi,

On Wed, 18 Apr 2007, Nicolas Pitre wrote:

> And because it now becomes a case by case issue it is much easier for us 
> to simply provide a generic mechanism and let people figure out by 
> themselves what works and what doesn't work instead of having 
> philosophical discussions on the merits of keyword expansions on the 
> list.

That's a very good point.

Ciao,
Dscho
