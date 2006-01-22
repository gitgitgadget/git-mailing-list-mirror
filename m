From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add git-pack-ls-objects tool
Date: Sun, 22 Jan 2006 04:00:42 +0100
Message-ID: <20060122030042.GS28365@pasky.or.cz>
References: <20060122022711.16333.93404.stgit@machine.or.cz> <7vzmlphtct.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 03:59:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0VRi-0006Yi-LI
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 03:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWAVC7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 21:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWAVC7L
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 21:59:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42144 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751258AbWAVC7L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 21:59:11 -0500
Received: (qmail 18491 invoked by uid 2001); 22 Jan 2006 04:00:42 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmlphtct.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15038>

Dear diary, on Sun, Jan 22, 2006 at 03:46:58AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > This tool takes pack index on stdin and produces the list of indexed
> > objects on stdout.
> 
> Isn't this essentially what git-show-index does?

Yes, I just had no idea this existed. ;)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
