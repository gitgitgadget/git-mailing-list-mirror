From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Unify usage strings declaration
Date: Fri, 29 Jul 2005 19:11:16 -0700
Message-ID: <7vfytx82m3.fsf@assigned-by-dhcp.cox.net>
References: <20050729085819.GL24895@pasky.ji.cz>
	<20050729090126.GN24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 04:16:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DygtP-0001ow-S9
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 04:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVG3CPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 22:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVG3CNr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 22:13:47 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:62169 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262927AbVG3CLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 22:11:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730021103.OVOV15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 22:11:03 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> All usage strings are now declared as static const char [].

I do not have preference either way, and I've already merged
them, but why char[] not char*?
