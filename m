From: Petr Baudis <pasky@suse.cz>
Subject: Re: FFmpeg considering GIT
Date: Thu, 3 May 2007 22:13:38 +0200
Message-ID: <20070503201338.GB18276@pasky.or.cz>
References: <loom.20070502T111026-882@post.gmane.org> <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz> <Pine.LNX.4.64.0705031302110.26172@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Panagiotis Issaris <takis.issaris@uhasselt.be>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu May 03 22:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjhgO-0007nk-NH
	for gcvg-git@gmane.org; Thu, 03 May 2007 22:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbXECUNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 16:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754265AbXECUNl
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 16:13:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48093 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271AbXECUNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 16:13:40 -0400
Received: (qmail 5574 invoked by uid 2001); 3 May 2007 22:13:38 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705031302110.26172@asgard.lang.hm>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46102>

On Thu, May 03, 2007 at 10:05:34PM CEST, david@lang.hm wrote:
> On Thu, 3 May 2007, Petr Baudis wrote:
> > Would crafting up a patch to implement something like this help ffmpeg
> >people in their decision?
> 
> is this needed?
> 
> wouldn't you do something like
> 
> a--b--c--d
> 
> oops, b was really bad
> 
> rebase c b
..snip..

This is immensely problematic, but I think I've fully covered all my
reservations in the other mail in this thread; if anything there was
unclear or you disagree with something I said, please reply to it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
