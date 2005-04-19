From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [RFC] Another way to provide help details. (was Re: [PATCH] Add help details to git help command.)
Date: Tue, 19 Apr 2005 03:51:24 +0200
Message-ID: <20050419015124.GW5554@pasky.ji.cz>
References: <200504172242.26326.elenstev@mesatop.com> <20050418102412.GJ1461@pasky.ji.cz> <4263E782.6040608@mesatop.com> <200504181940.54453.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 03:47:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNhpo-0001d0-2z
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 03:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVDSBv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 21:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDSBv2
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 21:51:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56499 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261197AbVDSBv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 21:51:26 -0400
Received: (qmail 4209 invoked by uid 2001); 19 Apr 2005 01:51:24 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <200504181940.54453.elenstev@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 03:40:54AM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> Here is perhaps a better way to provide detailed help for each
> git command.  A command.help file for each command can be
> written in the style of a man page.

I don't like it. I think the 'help' command should serve primarily as a
quick reference, which does not blend so well with a manual page - it's
too long and too convoluted by repeated output.

I'd just print the top comment from each file. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
