From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sat, 2 Feb 2008 15:58:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802021557190.7372@racer.site>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org> <87k5lnwvzd.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junichi Uekawa <dancer@netfort.gr.jp>
X-From: git-owner@vger.kernel.org Sat Feb 02 16:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLKly-0007dM-Sr
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 16:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621AbYBBP6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 10:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758676AbYBBP6r
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 10:58:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:46694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758501AbYBBP6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 10:58:46 -0500
Received: (qmail invoked by alias); 02 Feb 2008 15:58:44 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 02 Feb 2008 16:58:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/eRkdCo2veCjDZGH3U3gevS6kq5Vm2rXlzI36vjv
	xTkSf5eGT23jBK
X-X-Sender: gene099@racer.site
In-Reply-To: <87k5lnwvzd.dancerj%dancer@netfort.gr.jp>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72283>

Hi,

On Sat, 2 Feb 2008, Junichi Uekawa wrote:

> >    - Using dashed forms of git commands (e.g. "git-commit") from the
> >      command line has been informally deprecated since early 2006, but
> >      now it officially is, and will be removed in the future.  Use
> >      dash-less forms (e.g. "git commit") instead.
> 
> Hmm...
> 
> There are supplimentary tools, such as 'git-dch' and 'git-buildpackage' 
> which kind of supplied quasi-seamless extention to git family of tools, 
> are they going to be affected in some way?

AFAIU this only affects the programs that git installs.  Of course, git 
will search in that location first, but then in the rest of PATH.

Ciao,
Dscho
