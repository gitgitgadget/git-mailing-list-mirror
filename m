From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.18rc1
Date: Thu, 20 Jul 2006 18:26:28 +0200
Message-ID: <20060720162628.GL13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 20 18:27:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3bMK-0003Tn-9r
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 18:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWGTQ0a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWGTQ0a
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 12:26:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40648 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030359AbWGTQ0a (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 12:26:30 -0400
Received: (qmail 32583 invoked by uid 2001); 20 Jul 2006 18:26:28 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24032>

  Hello,

  I've just released cogito-0.18rc1, it should appear at kernel.org in a
few minutes.

  The highlights are pickaxe and patches showing support in cg-log,
(still somewhat broken but sometimes it works) support for renames
following in cg-log, cg-switch -l for stashing local changes when
switching, much enhanced tagging interface, cg-commit --amend,
cg-patch -m for applying mailboxes and other cool stuff; see the log for
details.

  Incompatible change is renaming $COGITO_COLORS to $CG_COLORS.

  P.S.: See us at #git @ FreeNode, or this afternoon at OLS! ;-)

  Happy hacking,

-- 
				Petr "Pasky the lousy poet" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
