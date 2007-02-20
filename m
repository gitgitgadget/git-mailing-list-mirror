From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Tue, 20 Feb 2007 02:43:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702200243140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <20070217233203.GA6014@coredump.intra.peff.net>
 <Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
 <7vodnp68p8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
 <7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
 <7vps854qf8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702200152230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b514nx4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 02:43:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJK2Z-0005Q5-2N
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 02:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932746AbXBTBnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 20:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbXBTBnc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 20:43:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:33854 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932746AbXBTBnb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 20:43:31 -0500
Received: (qmail invoked by alias); 20 Feb 2007 01:43:30 -0000
X-Provags-ID: V01U2FsdGVkX18CnRZBicgCiTg/LQghs9tS7GE7d4jAdB7bX6277Z
	tr+g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v3b514nx4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40194>

Hi,

On Mon, 19 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Wouldn't it be easier to just cd to the prefix?
> 
> I do not think so.  Think of what you need to do to the index.

Ouch. I did not even think of that. You're right.

Ciao,
Dscho
