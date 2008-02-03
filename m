From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 3 Feb 2008 10:50:02 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802031048320.7372@racer.site>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <87k5lnwvzd.dancerj%dancer@netfort.gr.jp> <878x22j1km.dancerj%dancer@netfort.gr.jp> <alpine.LSU.1.00.0802030210240.7372@racer.site> <877ihmivav.dancerj%dancer@netfort.gr.jp> <alpine.LSU.1.00.0802030321150.7372@racer.site>
 <871w7uitnt.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Sun Feb 03 11:51:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLcRP-00041R-W2
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbYBCKuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 05:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYBCKuj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:50:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:40638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753855AbYBCKui (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 05:50:38 -0500
Received: (qmail invoked by alias); 03 Feb 2008 10:50:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp047) with SMTP; 03 Feb 2008 11:50:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18QG/BNQJgQ1/gu1KksF1UWIXQe8w0UctHhZAr8mT
	0JZLThHm78X1mB
X-X-Sender: gene099@racer.site
In-Reply-To: <871w7uitnt.dancerj%dancer@netfort.gr.jp>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72350>

Hi,

On Sun, 3 Feb 2008, Junichi Uekawa wrote:

> 2. Custom scripts calling git tools with dash notation. (git-xxx).
>    -> they need to be modified and fixed.

Exactly, they need to be modified and fixed.  Which was why Junio wrote 
that part of his message, to warn you and everybody that you will need to 
fix your scripts.  Of course, you need not be in a hurry, this will not 
affect you in the next few weeks.

Ciao,
Dscho
