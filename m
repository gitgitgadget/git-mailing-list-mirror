From: Petr Baudis <pasky@suse.cz>
Subject: Re: Another gitweb wishlist
Date: Thu, 22 Sep 2005 14:33:40 +0200
Message-ID: <20050922123340.GI21019@pasky.or.cz>
References: <20050921201656.GA10575@pasky.or.cz> <20050921205416.GU15165MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 22 14:35:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIQH1-0000XX-Qn
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 14:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVIVMdn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 08:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVIVMdn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 08:33:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47595 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030278AbVIVMdm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 08:33:42 -0400
Received: (qmail 6377 invoked by uid 2001); 22 Sep 2005 14:33:40 +0200
To: kay.sievers@vrfy.org, ch@gierke.de, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050921205416.GU15165MdfPADPa@greensroom.kotnet.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9113>

Dear diary, on Wed, Sep 21, 2005 at 10:54:16PM CEST, I got a letter
where Sven Verdoolaege <skimo@kotnet.org> told me that...
> On Wed, Sep 21, 2005 at 10:16:56PM +0200, Petr Baudis wrote:
> >   (ii) I need persistent links to the latest version of <file>. Obvious
> > 
> > 	http://kernel.org/git/?p=cogito/cogito.git;a=blob;f=contrib/ciabot.pl
> > 
> 
> Works for me:
> http://www.liacs.nl/~sverdool/gitweb.cgi?p=barvinok.git;a=blob;f=README

This is good, however there is no easy way to see the file's history,
and showing the last repository commit with the file might lead to a
false impression that the commit actually touched the file, even if that
is not the case.

Also, trying to see your changes at

	http://www.liacs.nl/~sverdool/gitweb.cgi?p=gitweb.git;a=summary

shows how nice it would be to have some gitk-ish gitweb view.  That
would be probably a lot of work, though.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
