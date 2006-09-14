From: Petr Baudis <pasky@suse.cz>
Subject: Re: Historical kernel repository size
Date: Thu, 14 Sep 2006 17:52:31 +0200
Message-ID: <20060914155231.GU18896@pasky.or.cz>
References: <20060914142249.GK23891@pasky.or.cz> <46900.194.138.39.52.1158244729.squirrel@www.tglx.de> <45097775.4040005@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 17:52:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNtWD-0005os-0j
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 17:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWINPwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 11:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWINPwi
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 11:52:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9637 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750905AbWINPwh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 11:52:37 -0400
Received: (qmail 11457 invoked by uid 2001); 14 Sep 2006 17:52:31 +0200
To: Andy Whitcroft <apw@shadowen.org>
Content-Disposition: inline
In-Reply-To: <45097775.4040005@shadowen.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27005>

Dear diary, on Thu, Sep 14, 2006 at 05:38:29PM CEST, I got a letter
where Andy Whitcroft <apw@shadowen.org> said that...
> Is there any reason this isn't a live history.  ie that we don't
> constantly pull linus' master branch into this history to make it a real
> complete history?

Because at the early times of Git, things were evolving fast and it
would be unfeasible to have to drag this old history around in case of
format changes and stuff. Also, at that time history was still very big
and it would be impractical to require all the kernel developers to grab
all the bitkeeper history (it still kind of is).

> Perhaps that isn't possible ... hmmm.  I guess it might only work if
> linus' repo was actually a grafted version of this history?
> 
> /me watches his head explode.

	http://lkml.org/lkml/2006/6/17/110

may be useful.

It wasn't accepted. Oh well, I may try to resubmit it again soon. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
