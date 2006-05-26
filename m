From: Petr Baudis <pasky@suse.cz>
Subject: Re: ~/.git/config ?
Date: Fri, 26 May 2006 18:38:29 +0200
Message-ID: <20060526163829.GB10488@pasky.or.cz>
References: <20060526152837.GQ23852@progsoc.uts.edu.au> <20060526193325.d2a530a4.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anand Kumria <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 18:38:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjfKb-0008BI-Ez
	for gcvg-git@gmane.org; Fri, 26 May 2006 18:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWEZQiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 12:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWEZQiK
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 12:38:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29315 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751064AbWEZQiI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 May 2006 12:38:08 -0400
Received: (qmail 1146 invoked by uid 2001); 26 May 2006 18:38:29 +0200
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060526193325.d2a530a4.tihirvon@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20819>

Dear diary, on Fri, May 26, 2006 at 06:33:25PM CEST, I got a letter
where Timo Hirvonen <tihirvon@gmail.com> said that...
> I backup my $HOME using git, so there's a .git directory in ~.

Then it should be called ~/.gitconfig. :-)

> I don't think a global config file is really needed but it would be
> nice if .git/config would override the environment variables, not the
> other way around.

Then you have no other way to override .git/config e.g. when committing
patches submitted by other people.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
