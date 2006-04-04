From: Petr Baudis <pasky@suse.cz>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Tue, 4 Apr 2006 17:27:37 +0200
Message-ID: <20060404152737.GN27689@pasky.or.cz>
References: <443146EC.7060704@gentoo.org> <7virpqefp1.fsf@assigned-by-dhcp.cox.net> <20060403180929.GA14967@reactrix.com> <20060404100035.GM27689@pasky.or.cz> <20060404121056.GB14967@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 17:27:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQnR0-0000bE-Ke
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 17:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWDDP1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 11:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWDDP1F
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 11:27:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28087 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750715AbWDDP1E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 11:27:04 -0400
Received: (qmail 2192 invoked by uid 2001); 4 Apr 2006 17:27:37 +0200
To: Nick Hengeveld <nickh@reactrix.com>
Content-Disposition: inline
In-Reply-To: <20060404121056.GB14967@reactrix.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18392>

Dear diary, on Tue, Apr 04, 2006 at 02:10:57PM CEST, I got a letter
where Nick Hengeveld <nickh@reactrix.com> said that...
> On Tue, Apr 04, 2006 at 12:00:35PM +0200, Petr Baudis wrote:
> 
> > Well, what is the actual advantage of DAV compared to
> > git-update-server-info? Why would I prefer enabling DAV?
> 
> In theory, things should work the same either way.  It seems that in
> practice though, the server info files continue to surface as a source
> of fetch problems.

Because people do not know they have to set up their post-update hook.
When they are already going at lengths to find out how to set up DAV for
git fetch, they would discover the post-update hook way as well.

So, it really seems rather redundant to me.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
