From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.17.2
Date: Sat, 8 Apr 2006 03:06:26 +0200
Message-ID: <20060408010626.GR27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 03:05:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FS1tU-0000VD-3D
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 03:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWDHBFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 21:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWDHBFh
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 21:05:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18388 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751383AbWDHBFg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Apr 2006 21:05:36 -0400
Received: (qmail 26058 invoked by uid 2001); 8 Apr 2006 03:06:26 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18509>

  Hello,

  to join the series of git-related announcements, Cogito-0.17.2, the next
maintenance release on the current stable (v0.17) branch of Cogito, the
human-friendly version control system on top of Git, is available now.

  There are only very few changes, it looks that we are pretty stable:

Chris Wright:
      cogito spec BuildRequires update

Dennis Stosberg:
      cogito: Push tags over http

Petr Baudis:
      Improved cg-version output (use cg-object-id -d)
      cg-patch -c: Stop also at ^diff --git when slurping the commit message
      Fixed embarassing cg-admin-rewritehist bug
      Make cg-add/rm warnings less confusing: s/files/items/
      cogito-0.17.2


P.S.: Visit us at #git @ FreeNode!

  Happy hacking,

-- 
				Petr "Stable Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
