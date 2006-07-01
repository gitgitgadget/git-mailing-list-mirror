From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Add get_merge_bases_clean()
Date: Sun, 2 Jul 2006 01:43:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607020143010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060701232926.GA2513@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jul 02 01:44:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwp7z-0000qx-4k
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 01:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGAXnw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 19:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWGAXnv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 19:43:51 -0400
Received: from mail.gmx.net ([213.165.64.21]:41901 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932196AbWGAXnr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 19:43:47 -0400
Received: (qmail invoked by alias); 01 Jul 2006 23:43:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 02 Jul 2006 01:43:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20060701232926.GA2513@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23081>

Hi,

On Sun, 2 Jul 2006, Rene Scharfe wrote:

> Also move the object flags used in get_merge_bases() out of the range 
> defined in revision.h.  This fixes the "66ae0c77...ced9456a 
> 89719209...262a6ef7" test of the ... operator which is introduced with 
> the next patch.

Of COURSE! *hits his head on the table; table breaks; has to buy a new 
table*

Ciao,
Dscho
