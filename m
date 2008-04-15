From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: Website redesign
Date: Tue, 15 Apr 2008 13:54:31 +0200
Message-ID: <20080415115431.GA26302@machine.or.cz>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com> <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com> <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dill <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 13:55:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jljkw-0002GZ-V3
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760558AbYDOLyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 07:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758049AbYDOLyh
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:54:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58415 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbYDOLyg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:54:36 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 78EB5393B31E; Tue, 15 Apr 2008 13:54:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79588>

Please do not top-post, it makes it more difficult to follow the thread
and reply.

On Mon, Apr 14, 2008 at 08:38:25AM -0700, Dill wrote:
> Jonas Fonseca wrote:
> > If the home page should carry news it needs to have infrastructure
> > so that we don't need to bug Petr each time it should be updated. I
> > have commit access to the git-homepage repo and maybe Petr could add
> > others as well, but the question is if we want some web interface
> > for submitting news. I registered git-scm.org after the last survey
> > and right now it is just set up as an alias for git.or.cz. It comes
> > with some PHP capability which could serve as a place to develop a
> > redesign, however, I am not hosting it myself and I don't know what
> > kind of traffic will be required.

The server currently hosting git.or.cz could run PHP too if it would
make sense. I'd of course prefer Perl (and it would be easier to set
up), but I probably wouldn't do much of the coding myself, so it's not
up to me to decide.

> Isn't it possible to set up a git repo that has all the web page files
> and have it set up so the web site updates from that repo. Or just
> have Petr run a few commands. Or maybe that's what happens already.

This is exactly the current setup: http://repo.or.cz/w/git-homepage.git

> Then allow a few people to write to that repo. As far as the news go,
> the web page I set up is easily edited by hand and updated it's just
> how do we quickly allow updates without bothering people. Heres some
> more designs:
> 
> http://sarpulhu.googlepages.com/git5
> http://sarpulhu.googlepages.com/git6  -my personal favorite
> http://sarpulhu.googlepages.com/git7

I appreciate the effort, but frankly, I simply personally like the
current layout much more - the design certainly has quirks, but I don't
really find it bad; I also think that the current amount of content does
not justify splitting to multiple pages. The newly proposed version
looks to me just as barebone graphically as the old one, with the same
level of navigability but wasting screen estate and requiring more
clicks to get where you need.

That said, this can (and quite probably does) merely mean that I simply
have no taste at all and should be kept away from any kind of web
design! :-) So, I do not want to inhibit progress at all, but before
considering to adopt the new design, I would prefer to see wider
feedback from the core members of the community to convince me that I'm
wrong.

Something in the style of earlier mentioned restlet.org might not be
necessarily bad (though I'm slightly wary of too toyish-looking
graphics), but it appears to me that graphically, that site is simply on
a completely different level than the current proposals. But if someone
would do some cute design, I believe the current layout could look quite
nice too - after all, consider http://bazaar-vcs.org/ (modulo the wiki
artifacts plague).

Kind regards,

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
