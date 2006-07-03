From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2] autoconf: Use ./configure script in git *.spec file
Date: Sun, 02 Jul 2006 17:13:29 -0700
Message-ID: <7vodw7zgt2.fsf@assigned-by-dhcp.cox.net>
References: <200607030156.50455.jnareb@gmail.com>
	<200607030202.55919.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 02:13:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxC4E-0003n4-DM
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 02:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWGCANc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 20:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWGCANb
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 20:13:31 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6572 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750733AbWGCANb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 20:13:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703001330.TLQC19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 20:13:30 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200607030202.55919.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 3 Jul 2006 02:02:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23144>

I thought this stuff was "opt-in", but make rpm now requires
autoconf?
