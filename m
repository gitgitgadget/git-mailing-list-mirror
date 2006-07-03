From: Petr Baudis <pasky@suse.cz>
Subject: Re: [POLL] Who likes running Git without make install?
Date: Mon, 3 Jul 2006 10:17:25 +0200
Message-ID: <20060703081725.GM29115@pasky.or.cz>
References: <7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net> <20060625010202.GX21864@pasky.or.cz> <20060625014009.GA21864@pasky.or.cz> <7vac82q6mb.fsf@assigned-by-dhcp.cox.net> <20060625152157.GG21864@pasky.or.cz> <7vk674mmyo.fsf@assigned-by-dhcp.cox.net> <20060701235906.GE29115@pasky.or.cz> <7vslljrxe0.fsf_-_@assigned-by-dhcp.cox.net> <20060703075850.GL29115@pasky.or.cz> <7vmzbrrtz4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 10:17:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxJcY-0006qc-KI
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 10:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWGCIR1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 04:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWGCIR1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 04:17:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13969 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750891AbWGCIR1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 04:17:27 -0400
Received: (qmail 15149 invoked by uid 2001); 3 Jul 2006 10:17:25 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzbrrtz4.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23164>

Dear diary, on Mon, Jul 03, 2006 at 10:08:31AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Mon, Jul 03, 2006 at 08:54:47AM CEST, I got a letter
> > where Junio C Hamano <junkio@cox.net> said that...
> >> -- >8 --
> >> INSTALL: a tip for running after building but without installing.
> >> 
> >> Signed-off-by: Junio C Hamano <junkio@cox.net>
> >
> > Acked-by: Petr Baudis <pasky@suse.cz>
> >
> > I can live with this "weak (D3)". 99% of Git users probably use
> > installed Git instance anyway and most of the rest are likely to be Git
> > developers testing new code who can do this extra environment setup.
> 
> You earlier had to set two environment variables anyway but you
> have added another.  I do not see what's weak about it.

I don't usually use the git wrapper so I got away without setting
GIT_EXEC_PATH yet. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
