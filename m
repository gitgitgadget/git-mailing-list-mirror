From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] Cogito 0.12.1
Date: Tue, 12 Jul 2005 03:00:58 +0200
Message-ID: <20050712010058.GE5981@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 12 03:03:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds9Bb-00079h-KQ
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 03:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVGLBCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 21:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVGLBCG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 21:02:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41873 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261796AbVGLBBA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 21:01:00 -0400
Received: (qmail 25589 invoked by uid 2001); 12 Jul 2005 01:00:58 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  here is Cogito 0.12.1, another desperate attempt to keep pace with
'@' or Linus, the named Human Master Coder. (Linus, the Human Master
Coder, mumbles arcane do { formulae } while (0)!  Some kind of force
seems to attack your mind.  Everything suddenly looks so different...
You are confused.)  Visit the greater spellbook vault at

	http://www.kernel.org/pub/software/scm/cogito

or re-attune yourself to the git plane (in case you are already
connected to the mana flow of Cogito) for updated powerful
counter-magick.

  Most of it is upstream stuff. Otherwise, almost everything are
bugfixes and updates to deal better with the mighty pack stuff.
Important bugfixes is fixed parent-id (cg-admin-uncommit, subsequently)
and massive pull fixes w.r.t. pulling from packed repositories and
cross-filesystem local pull.

  Oh, don't get used too much to the new cg-info script's semantics,
I want to move the functionality to cg-status; I just forgot to do it
before tagging the release and only remembered it now.

  May the sun always shine on you,

-- 
			Petr "the High Elven Codethrower" Baudis
Stuff: http://pasky.or.cz/
You play too little rogue-like RPG games, apparently.
