From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-snapshot-20060831 error
Date: Thu, 31 Aug 2006 13:19:25 +0200
Message-ID: <20060831111925.GA18896@pasky.or.cz>
References: <44F6C262.8040605@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 13:19:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIka3-0005Uy-Ek
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 13:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWHaLT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 07:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWHaLT1
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 07:19:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:23692 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751271AbWHaLT1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 07:19:27 -0400
Received: (qmail 11545 invoked by uid 2001); 31 Aug 2006 13:19:25 +0200
To: Jorma Karvonen <karvjorm@users.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <44F6C262.8040605@users.sourceforge.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26250>

  Hi,

Dear diary, on Thu, Aug 31, 2006 at 01:05:06PM CEST, I got a letter
where Jorma Karvonen <karvjorm@users.sourceforge.net> said that...
> I tried to compile git, but got the following error:

  try doing

	make NEEDS_LIBICONV=1

or running ./configure if you have git version new enough. If that
doesn't help, what git version are trying to compile on what kind of
system?

> http://web.maxinetti.fi/maxi.joka/git_snapshot_20060831_error1.png

  Please paste error messages as plain text, not screenshots. Thanks.

> Please, can you forward that link to developers of git.

  The developers are listening eagerly at git@vger.kernel.org.

  Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
