From: Petr Baudis <pasky@suse.cz>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 9 Dec 2005 22:33:35 +0100
Message-ID: <20051209213335.GU22159@pasky.or.cz>
References: <20051209094328.GT22159@pasky.or.cz> <20051209140123.3234.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: alan@chandlerfamily.org.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 22:33:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekps1-0003lc-TG
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 22:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVLIVdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 16:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVLIVde
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 16:33:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55696 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964878AbVLIVde (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2005 16:33:34 -0500
Received: (qmail 8798 invoked by uid 2001); 9 Dec 2005 22:33:35 +0100
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20051209140123.3234.qmail@science.horizon.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13436>

Dear diary, on Fri, Dec 09, 2005 at 03:01:23PM CET, I got a letter
where linux@horizon.com said that...
> >> Unfortunately, given the number of commands, you can't just document
> >> them well individually.  Some overview of how they fit together into
> >> a system is required.
> 
> > Hmm. Well, actually... what's the point? If I want to get a really quick
> > overview, I do
> >
> >	whatis git
> >
> > and it will DTRT. But when do I need something more detailed but not yet
> > the manual page of the given command?
> 
> "I want to do X and Y but not Z.  What commands are worth knowing?"

Well, yes, that's the approach I advocate as well! It's precisely the
"task-based structured documentation" I talked about.

But the command listing is something different, actually the opposite:

"See, you have all those commands A, B, C. And this is what you can do
with them."

That's to say, the former requires a lot more effort and writing than
the latter and the latter has its uses as well, although I still think
the former is superior. :-)

> (BTW, don't you mean "whatis -w git\*"?)

$ whatis git
git                  (7)  - the stupid content tracker
git-add              (1)  - Add files to the index file
git-am               (1)  - Apply a series of patches in a mailbox

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
