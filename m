From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add a --prefix option to git-daemon
Date: Tue, 25 Oct 2005 11:10:57 +0200
Message-ID: <20051025091057.GA30889@pasky.or.cz>
References: <200510250708.j9P78pG3024087@gameboy2.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 11:13:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUKpm-0001UB-RA
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 11:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVJYJLB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 05:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVJYJLB
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 05:11:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41871 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932101AbVJYJLA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 05:11:00 -0400
Received: (qmail 15411 invoked by uid 2001); 25 Oct 2005 11:10:57 +0200
To: Brad Roberts <braddr@gameboy2.puremagic.com>
Content-Disposition: inline
In-Reply-To: <200510250708.j9P78pG3024087@gameboy2.puremagic.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10575>

Dear diary, on Tue, Oct 25, 2005 at 09:08:51AM CEST, I got a letter
where Brad Roberts <braddr@gameboy2.puremagic.com> told me that...
> Add a --prefix option to git-daemon.  This path is prepended to the search
> path for repositories.  In other words, git://hostname/path/to/gitdir will
> result in looking for /prefix/path/to/gitdir.
> 
> Signed-off-by: Brad Roberts <braddr@puremagic.com>

You forgot to document the option. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
