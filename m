From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 21:30:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272129070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net> <86odnfr625.fsf@blue.stonehenge.com>
 <7vzm6zcpv0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:32:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8zc-000412-SX
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbXB0Ua6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbXB0Ua6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:30:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:51678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751806AbXB0Uaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:30:55 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:30:54 -0000
X-Provags-ID: V01U2FsdGVkX18S59MidQcSr2R5kihtjjgawfbLkyaMmCLR+Mpo16
	njYA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm6zcpv0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40788>

Hi,

On Tue, 27 Feb 2007, Junio C Hamano wrote:

> 75b62b48 (combine-diff broken cast)
> 	e702496e Aug 23 2006 (memcpy->hashcpy)
> 	funny thing is that another similar cast is correct.
> 
> Johannes Schindelin.

... while working on some diff --no-index code. (Strangely enough.)

Ciao,
Dscho
