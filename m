From: Petr Baudis <pasky@suse.cz>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 23:59:56 +0200
Message-ID: <20060327215956.GB27689@pasky.or.cz>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz> <Pine.LNX.4.64.0603260829550.15714@g5.osdl.org> <20060326191445.GQ18185@pasky.or.cz> <20060326232649.GV18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 00:00:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNzkm-0001Gs-KB
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 00:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWC0V74 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 16:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWC0V74
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 16:59:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:63418 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751485AbWC0V74 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 16:59:56 -0500
Received: (qmail 8368 invoked by uid 2001); 27 Mar 2006 23:59:56 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20060326232649.GV18185@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18088>

Dear diary, on Mon, Mar 27, 2006 at 01:26:49AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> To quickly see what it does, you can try it e.g. on the git-log.sh file
> in the Git repository.

By the way, the cg-log in master uses it now to automagically follow
file renames (in case you call it per-file like cg-log FILENAME). If you
hate it, you can prevent it by cg-log --no-renames (cg-log -R).

Looks pretty slick.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
