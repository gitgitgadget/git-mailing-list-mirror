From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] fix tests so they run without needing bash
Date: Thu, 25 May 2006 20:01:27 -0700
Message-ID: <7vu07dqyk8.fsf@assigned-by-dhcp.cox.net>
References: <1148609178788-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 05:01:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjSZw-0005Ik-6a
	for gcvg-git@gmane.org; Fri, 26 May 2006 05:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWEZDB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 23:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWEZDB3
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 23:01:29 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:14468 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030219AbWEZDB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 23:01:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060526030128.MKQP15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 23:01:28 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <1148609178788-git-send-email-normalperson@yhbt.net> (Eric Wong's
	message of "Thu, 25 May 2006 19:06:14 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20781>

You are my hero.

I've really been wanting to get rid of bashism and trying to run
everything with dash was one of my goals.  Although recent trend
seems to indicate people are more interested in getting rid of
shell scripts altogether, it is nice to see somebody actually
cares.
