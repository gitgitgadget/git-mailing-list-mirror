From: Petr Baudis <pasky@ucw.cz>
Subject: cg-log -r?
Date: Mon, 2 May 2005 02:04:47 +0200
Message-ID: <20050502000447.GF974@pasky.ji.cz>
References: <20050502000019.GA1644@fatelectrons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 01:58:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSOKp-0007eu-RQ
	for gcvg-git@gmane.org; Mon, 02 May 2005 01:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVEBAEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 20:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVEBAEv
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 20:04:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32669 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261481AbVEBAEt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 20:04:49 -0400
Received: (qmail 12510 invoked by uid 2001); 2 May 2005 00:04:47 -0000
To: Alexander Beyn <malex-git@fatelectrons.org>
Content-Disposition: inline
In-Reply-To: <20050502000019.GA1644@fatelectrons.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 02, 2005 at 02:00:19AM CEST, I got a letter
where Alexander Beyn <malex-git@fatelectrons.org> told me that...
> I created it because I could never remember if cg-log or cg-diff requires 
> the -r before the revs.

Actually, would you people hate me / Cogito / Richard Stallman if I
added -r to cg-log and cg-mkpatch, for the sake of consistency?
Extending cg-log to work on individual files would be then obvious.


P.S.: Yes, I'm back and hope to catch with the rest of you during tomorrow.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
