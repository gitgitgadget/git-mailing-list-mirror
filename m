From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/3] Core GIT fixes and additions.
Date: Thu, 12 May 2005 17:14:16 -0700
Message-ID: <7v7ji4c78n.fsf_-_@assigned-by-dhcp.cox.net>
References: <118833cc05050911255e601fc@mail.gmail.com>
	<7vr7gewuxt.fsf@assigned-by-dhcp.cox.net>
	<20050510230357.GF26384@pasky.ji.cz>
	<7vsm0us5p5.fsf@assigned-by-dhcp.cox.net>
	<118833cc050511113122e2d17d@mail.gmail.com>
	<7vpsvxqwab.fsf@assigned-by-dhcp.cox.net>
	<7vd5rxquo5.fsf@assigned-by-dhcp.cox.net>
	<20050511224044.GI22686@pasky.ji.cz>
	<7vu0l9nwgx.fsf_-_@assigned-by-dhcp.cox.net>
	<20050512192941.GC324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 02:07:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWNhw-0007pm-PB
	for gcvg-git@gmane.org; Fri, 13 May 2005 02:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbVEMAOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 20:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVEMAOo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 20:14:44 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64650 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262185AbVEMAOn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 20:14:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513001415.PIJE22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 20:14:15 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050512192941.GC324@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 12 May 2005 21:29:41 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pasky,
        I am sending you three patches rediffed against the tip
of git-pb tree for inclusion.

  * [PATCH 1/3] Introduce "rev-list --stop-at=<commit>".
  * [PATCH 2/3] Support symlinks in git-ls-files --others.
  * [PATCH 3/3] Add git-ls-files -k.

The first one is independent from other two.  3/3 touches the
same file as 2/3.

