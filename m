From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Cogito-0.17rc1
Date: Thu, 16 Feb 2006 14:02:00 +0100
Message-ID: <20060216130200.GQ31278@pasky.or.cz>
References: <20060212171154.GW31278@pasky.or.cz> <20060216102059.17009.qmail@8b7ebad5023b2c.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Feb 16 14:01:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9ikw-0003Hc-0d
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 14:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030600AbWBPNBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 08:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbWBPNBH
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 08:01:07 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58250 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030600AbWBPNBG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 08:01:06 -0500
Received: (qmail 28661 invoked by uid 2001); 16 Feb 2006 14:02:00 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060216102059.17009.qmail@8b7ebad5023b2c.315fe32.mid.smarden.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16298>

Dear diary, on Thu, Feb 16, 2006 at 11:20:59AM CET, I got a letter
where Gerrit Pape <pape@smarden.org> said that...
> On Sun, Feb 12, 2006 at 06:11:54PM +0100, Petr Baudis wrote:
> >   I'm announcing the release of Cogito version 0.17rc1, the human-friendly
> > version control UI for Linus' GIT tool. Share and enjoy at:
> > 
> > 	http://www.kernel.org/pub/software/scm/cogito/
> 
> Hi, the selftests for cg-seek fail for me on Debian/unstable:

Yes, I've noticed that afterwards as well - I can't tell how that
slipped through, I could swear that I ran the testsuite before the
release... :/

It's fixed in 0.17rc2. Thanks for the report,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
