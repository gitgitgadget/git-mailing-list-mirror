From: Petr Baudis <pasky@suse.cz>
Subject: Re: Enable the packed refs file format
Date: Tue, 19 Sep 2006 22:55:54 +0200
Message-ID: <20060919205554.GA8259@pasky.or.cz>
References: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 19 22:58:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPmdL-0003Ig-Ok
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 22:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWISUz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWISUz5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 16:55:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9629 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751799AbWISUz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 16:55:56 -0400
Received: (qmail 18347 invoked by uid 2001); 19 Sep 2006 22:55:54 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27282>

Dear diary, on Thu, Sep 14, 2006 at 07:14:47PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> +	ref_file = git_path(ref);

You slip...
You fall...
*BLAMMMM!!!*

Cloning a repository with '%s' tag over HTTP now dumps core nicely, and
I guess this kind of bugs tends to be exploitable.

-- 
				Petr "Pasky Yay for Obscure ADOM
					References" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
