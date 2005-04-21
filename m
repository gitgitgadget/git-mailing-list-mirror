From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Pasky problem with 'git init URL'
Date: Thu, 21 Apr 2005 23:26:49 +0200
Message-ID: <20050421212648.GM7443@pasky.ji.cz>
References: <1114100518.17551.31.camel@nosferatu.lan> <20050421202928.GH7443@pasky.ji.cz> <17000.6154.748117.967898@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:24:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOj7v-0007Rp-BZ
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 23:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVDUV0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 17:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVDUV0w
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 17:26:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51080 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261887AbVDUV0u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 17:26:50 -0400
Received: (qmail 24022 invoked by uid 2001); 21 Apr 2005 21:26:49 -0000
To: John Stoffel <john@stoffel.org>
Content-Disposition: inline
In-Reply-To: <17000.6154.748117.967898@smtp.charter.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 11:15:54PM CEST, I got a letter
where John Stoffel <john@stoffel.org> told me that...
> >>>>> "Petr" == Petr Baudis <pasky@ucw.cz> writes:
> 
> Petr> Perhaps it would be useful to have some "command classes" (with at least
> Petr> cg-*-(add|ls|rm)), like:
> 
> Petr> 	cg-branch-ls
> Petr> 	cg-remote-rm
> Petr> 	cg-tag-add
> 
> Does a standard like:
> 
>   git <objecttype> <command> <args> [<obj> ...]

Isn't this basically what I was proposing? (Modulo the UI changes
related to git-pasky -> Cogito.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
