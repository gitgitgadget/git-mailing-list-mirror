From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Sun, 8 Oct 2006 22:10:31 +0200
Message-ID: <20061008201031.GL20017@pasky.or.cz>
References: <20060919212725.GA13132@pasky.or.cz> <ef43do$fm1$1@sea.gmane.org> <7vac4qs43g.fsf@assigned-by-dhcp.cox.net> <200610061231.06017.jnareb@gmail.com> <egauic$1l2$1@sea.gmane.org> <7vwt7aio8l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 22:10:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWeys-00017J-Nv
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 22:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWJHUKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 16:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWJHUKd
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 16:10:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52702 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751354AbWJHUKd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 16:10:33 -0400
Received: (qmail 10633 invoked by uid 2001); 8 Oct 2006 22:10:31 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt7aio8l.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28547>

Dear diary, on Sun, Oct 08, 2006 at 09:47:22PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Was this patch dropped? Postponed to after release?
> > Waiting for better patch (but this correct esc_html-ing URL...)?
> 
> Pretty much the last one -- waiting for a patch directly
> applicable from my e-mail client.  As far as I can recall there
> has been none in the thread.

Is there a problem with taking <200610061231.06017.jnareb@gmail.com>?

I think it's currently not worth the complexity and breakage of
backwards compatibility to do the more elaborate form you proposed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
