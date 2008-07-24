From: Petr Baudis <pasky@suse.cz>
Subject: gitweb tags feed, Re: New version announcements?
Date: Thu, 24 Jul 2008 16:49:39 +0200
Message-ID: <20080724144939.GI10151@machine.or.cz>
References: <3B8DB770-5ADC-4B99-9A12-F1DABA20C34D@bunster.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jordi Bunster <jordi@bunster.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:52:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM2BB-0004v3-JU
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757634AbYGXOtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757762AbYGXOts
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:49:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49158 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758811AbYGXOtr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:49:47 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5DC52393B336; Thu, 24 Jul 2008 16:49:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3B8DB770-5ADC-4B99-9A12-F1DABA20C34D@bunster.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89892>

  Hi,

On Thu, Jul 24, 2008 at 10:38:24AM -0400, Jordi Bunster wrote:
> I've been following the git mailing list to stay on top of new releases, 
> but the traffic got too high.
>
> Any way that a git-announce list could be created for security fixes and 
> new releases? Or maybe an RSS feed on the website?
>
> If there's a news file or some-such, I'd be glad to write the code to 
> convert it to a subscription feed.

  I believe you meant to write this to the list directly, I'm cc'ing it
now. Basically, this depends on whether Junio finds it worth-while. :-)
I think these requests do not pop up often, but that might mean that
most people are simply discouraged right away and too shy to ask for it.

  One thing that comes on my mind would be to implement RSS feed of new
tags to gitweb; this could supply the information about new releases
easily. Any bored gitweb hacker willing to implement this? ;-)

  (Of course, it is a bit of pity that release announcements aren't part
of the tag comment when Git already makes tag comments possible; that
could be a part of the feed. Maybe with the feed as a nice use-case,
Junio could get convinced to do that though, if it doesn't disrupt his
release workflow too much.)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
