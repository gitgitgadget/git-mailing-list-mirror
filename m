From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.17.4
Date: Sun, 24 Sep 2006 22:34:15 +0200
Message-ID: <20060924203415.GZ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 22:34:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRag9-0002wm-76
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 22:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWIXUeR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 16:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWIXUeR
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 16:34:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18318 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932067AbWIXUeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 16:34:16 -0400
Received: (qmail 21489 invoked by uid 2001); 24 Sep 2006 22:34:15 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27694>

  Hello,

  cogito-0.17.4 was just released - bugfixes release on the latest
stable line of the Cogito user-friendly Git user interface.

  Just a few tiny bugfixes.  So, what's new?

  * Make cg-commit -p imply -e
  * Fix cg-commit -M with relative path called from a subdirectory
  * Be way more paranoid when failing to apply patches w/ cg-commit -p
  * Do not use type -P (bash31ism)
  * Make documentation build with `make` not being GNU make
  * When fetching, autofollow lightweight tags as well

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
