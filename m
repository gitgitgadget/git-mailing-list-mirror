From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 3/4] Teach git-local-fetch the --stdin switch
Date: Fri, 28 Jul 2006 03:57:27 +0200
Message-ID: <20060728015727.GJ13776@pasky.or.cz>
References: <20060727215326.24240.20118.stgit@machine> <20060727215622.24240.56894.stgit@machine> <20060727215326.24240.20118.stgit@machine> <20060727215619.24240.39537.stgit@machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 03:57:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Hbd-0008VI-0H
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 03:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWG1B5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 21:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWG1B5a
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 21:57:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55187 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932115AbWG1B53 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 21:57:29 -0400
Received: (qmail 26873 invoked by uid 2001); 28 Jul 2006 03:57:27 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060727215622.24240.56894.stgit@machine> <20060727215619.24240.39537.stgit@machine>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24361>

Dear diary, on Thu, Jul 27, 2006 at 11:56:19PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> +--stdin::
> +	Instead of a commit id on the commandline (which is not expected in this
> +	case), 'git-local-fetch' excepts lines on stdin in the format
                                 ^^^^^^^

Oops, should read "expects" in both patches - thanks, alp!

I blame all those tiny bugs lured into the room by light and then, well,
bugging you. (Real-world bugs, but they can transform.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
