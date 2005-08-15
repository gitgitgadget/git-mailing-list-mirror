From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 00:44:44 -0700
Message-ID: <7vvf273aqb.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050814235140877be7@mail.gmail.com>
	<7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
	<46a038f90508150037f128d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 09:46:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ZeM-0005jX-EV
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 09:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVHOHoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 03:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVHOHoq
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 03:44:46 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9870 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932155AbVHOHoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 03:44:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050815074446.XXAG17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 03:44:46 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508150037f128d6@mail.gmail.com> (Martin Langhoff's
	message of "Mon, 15 Aug 2005 19:37:19 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> I think -kv is just the wrong thing to do if you are migrating to git.
> Anyway, this script has so far followed cvs's own default... which is
> -kv, and I am generally unwilling to break backwards compatibility.

Isn't cvs default -kkv?
