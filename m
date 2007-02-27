From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 23:24:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272322590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAk3-0003gn-Ti
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbXB0WYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXB0WYN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:24:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:47258 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751947AbXB0WYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:24:12 -0500
Received: (qmail invoked by alias); 27 Feb 2007 22:24:11 -0000
X-Provags-ID: V01U2FsdGVkX1993dAFJll9OSrT1X5796uAxGl1ztGEgaRYssA6Dw
	efhQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40825>

Hi,

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> Side note: one of the reasons I like having more fine-grained date flags 
> is that I've occasionally wanted a "show in UTC time" or "show 
> everything in *my* local time" option.

I found the --relative-date option very useful to that end, if a bit long 
to type.

Ciao,
Dscho

P.S.: It is refreshing to see somebody using the same convention of 
one-space-after-full-stop as me. Europeans...
