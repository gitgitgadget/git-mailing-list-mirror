From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5000: silence unzip availability check
Date: Sat, 9 Jun 2007 15:37:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706091526380.4059@racer.site>
References: <alpine.LFD.0.98.0706050908520.23741@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706051819290.4046@racer.site> <Pine.LNX.4.64.0706061956540.4046@racer.site>
 <466A4930.2020602@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2022148687-1181399138=:4059"
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 09 16:41:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx27x-0004di-LM
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 16:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbXFIOlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 10:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbXFIOlL
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 10:41:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:53304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751593AbXFIOlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 10:41:09 -0400
Received: (qmail invoked by alias); 09 Jun 2007 14:41:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 09 Jun 2007 16:41:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18EjNpg/kkEIAGreVq2s2SSxblsfzrdHBDNFQ4raf
	eNBmLdhy8JVFG0
X-X-Sender: gene099@racer.site
In-Reply-To: <466A4930.2020602@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49574>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2022148687-1181399138=:4059
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 9 Jun 2007, René Scharfe wrote:

> unzip -v on (at least) Ubuntu prints a screenful of version info
> to stdout.  Get rid of it since we only want to know if unzip is
> installed or not.

Makes sense, absolutely.

ACK,
Dscho
--8323584-2022148687-1181399138=:4059--
