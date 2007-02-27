From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Wed, 28 Feb 2007 00:10:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702280010020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272313020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271453030.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBTM-0008Ed-Jb
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbXB0XLB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbXB0XLA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:11:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:40732 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752008AbXB0XLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:11:00 -0500
Received: (qmail invoked by alias); 27 Feb 2007 23:10:58 -0000
X-Provags-ID: V01U2FsdGVkX18tiDRcyX0tHA+d8Zuz4ZsekyOEKtK0y1dqx+scB2
	omWA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702271453030.12485@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40837>

Hi,

On Tue, 27 Feb 2007, Linus Torvalds wrote:

> But the "short date + author name" on one line part I certainly don't 
> disagree with.

If you use "next" Git:

	$ git log --pretty=format:"%h %ad %an"

Ciao,
Dscho
