From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-daemon: timeout, eliminate double DWIM
Date: Thu, 20 Oct 2005 03:26:15 +0200
Message-ID: <20051020012615.GU30889@pasky.or.cz>
References: <4356966A.8010401@zytor.com> <20051020002845.GT30889@pasky.or.cz> <7vsluxvvdc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 03:26:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESPCP-0001jX-7l
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 03:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbVJTB0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 21:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbVJTB0S
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 21:26:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5833 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751675AbVJTB0R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 21:26:17 -0400
Received: (qmail 23098 invoked by uid 2001); 20 Oct 2005 03:26:15 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsluxvvdc.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10334>

Dear diary, on Thu, Oct 20, 2005 at 03:18:39AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > You didn't update Documentation/git-daemon.txt.
> >...
> > Ditto.
> 
> Patches welcome.

Ah, I didn't notice it was already merged, sorry.


BTW, some of the commits in your tree have the same author and
committer date while they shouldn't:

author H. Peter Anvin <hpa@zytor.com> Wed, 19 Oct 2005 14:27:01 -0700
committer Junio C Hamano <junkio@cox.net> Wed, 19 Oct 2005 14:27:01 -0700

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
