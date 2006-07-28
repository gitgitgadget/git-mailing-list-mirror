From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow fetching from multiple repositories at once
Date: Fri, 28 Jul 2006 00:35:18 -0700
Message-ID: <7v7j1ymbbd.fsf@assigned-by-dhcp.cox.net>
References: <20060728054341.15864.35862.stgit@machine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, alp@atoker.com
X-From: git-owner@vger.kernel.org Fri Jul 28 09:35:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6MsV-0001Mt-CQ
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 09:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWG1HfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 03:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWG1HfU
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 03:35:20 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36486 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932586AbWG1HfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 03:35:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060728073519.TJDT554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Jul 2006 03:35:19 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060728054341.15864.35862.stgit@machine> (Petr Baudis's message
	of "Fri, 28 Jul 2006 07:44:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24374>

This is quite heavyweight.

I'll take a look at it eventually ;-), but I'd like to take a
deeper look at merge-recursive by Johannes and Alex first.
Perhaps I can get to it over the weekend, but Saturday is
already booked for friends' wedding, so it might take a while.
