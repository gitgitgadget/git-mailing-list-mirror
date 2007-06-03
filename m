From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC PATCH] Add git quick reference
Date: Sun, 3 Jun 2007 13:15:47 -0400
Message-ID: <20070603171547.GA1965@fieldses.org>
References: <20070602182423.GC19952@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Jun 03 19:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HutgI-0006aD-UP
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 19:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbXFCRPt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 13:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbXFCRPt
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 13:15:49 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56077 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbXFCRPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 13:15:49 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HutgB-0000fq-Mw; Sun, 03 Jun 2007 13:15:47 -0400
Content-Disposition: inline
In-Reply-To: <20070602182423.GC19952@diku.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49014>

On Sat, Jun 02, 2007 at 08:24:23PM +0200, Jonas Fonseca wrote:
> It attempts to list some of the most commonly used commands, which should
> give new users an idea of how to get started.
> 
> Available both as a manpage (generated via a script) and HTML page.

We have a "git quick start" here:

	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#git-quick-start

and there's one on the wiki:

	http://git.or.cz/gitwiki/QuickStart

I think the one in the manual tries to follow the organization of the
manual more closely.

I haven't tried to compare those two recently, or to compare yours to
either of them.  If you could compare and suggest any improvements,
that'd be helpful.

I like your name better ("quick reference" as opposed to "quick start").

Having it as a man page may be a good idea too.  I'd like to keep a copy
in the manual as well, though, so we'd have to include from some common
file.

--b.
