From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 03:00:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180259340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsld4p99g.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180210490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b54p78r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 03:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIbMR-0001ZL-BV
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 03:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbXBRCBD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 21:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbXBRCBD
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 21:01:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:44321 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161039AbXBRCBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 21:01:01 -0500
Received: (qmail invoked by alias); 18 Feb 2007 02:01:00 -0000
X-Provags-ID: V01U2FsdGVkX18pxF0q64cpBC9WoOz5qeI2Hgi0QYGoTLowc/73L0
	ExZA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v3b54p78r.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40052>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> I do agree diff-file is too confusing with diff-files, but...

... but nobody writes out diff-files these days, right?

> In any case, I am done for the evening, and your patch did not apply to 
> any of the well-known versions, so perhaps I can take a rest and have 
> dinner and hope to find a respun one that everybody on the list agrees 
> with its name in my mailbox later? ;-)

;-)

Well, that'll have to wait a bit. I am way past bed-time. Same goes for 
the colour --check thing. Will work on that tomorrow or Monday.

Ciao,
Dscho
