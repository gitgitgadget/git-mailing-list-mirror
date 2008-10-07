From: Jeff King <peff@peff.net>
Subject: Re: GitTogether topics status (4th of October)
Date: Mon, 6 Oct 2008 23:15:09 -0400
Message-ID: <20081007031509.GA6031@coredump.intra.peff.net>
References: <200810041816.41026.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Petr Baudis <pasky@suse.cz>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 05:16:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn33g-0006Fr-ER
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 05:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633AbYJGDPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 23:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYJGDPN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 23:15:13 -0400
Received: from peff.net ([208.65.91.99]:2216 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487AbYJGDPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 23:15:11 -0400
Received: (qmail 27193 invoked by uid 111); 7 Oct 2008 03:15:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 06 Oct 2008 23:15:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Oct 2008 23:15:09 -0400
Content-Disposition: inline
In-Reply-To: <200810041816.41026.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97660>

On Sat, Oct 04, 2008 at 06:16:40PM +0200, Christian Couder wrote:

> As can be seen on the GitTogether page on the wiki: 
> 
> http://git.or.cz/gitwiki/GitTogether
> 
> the planned speakers/topics changed a lot during the last weeks and are now:

I just added two proposed half-hour meetings, both of which I intend to
be a few minutes of me talking followed by group discussion. The topics
are:

  1. Helping new developers join the git community

     This title is a little bit sneaky. I want to talk about not just how
     we can get new developers to help improve git, but also how we can
     convince them to adopt workflows that make less work for reviewers
     and maintainers. It seems like there are some things that we tell
     new people over and over about formatting code, formatting patches,
     sending patches, etc. Probably the end goal will be improvements to
     SubmittingPatches, but maybe putting similar content somewhere more
     visible, or maybe even adjusting our workflows a bit.

     I hope to make it useful for veterans (who may _constructively_
     complain about the habits of new developers), and new developers,
     who may learn something about contributing.

     This might overlap a bit with Dscho's "contributing with git" talk
     (which I am not sure is a talk about using git to contribute in
     general, or using git to contribute to git), but I think the
     discussion-like forum will make it different enough to be valuable.

  2. What needs refactoring?

     I occasionally run up against parts of the code that just make my
     eyes bleed everytime I touch them. I think we've made significant
     progress in maintanability and bug-avoidance with things like the
     strbuf library, refactoring of remote and transport handling, etc.
     What areas might still benefit from such refactoring?

-Peff
