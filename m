From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use correct U*MAX.
Date: Fri, 03 Jun 2005 16:40:21 -0700
Message-ID: <7v4qcfko0q.fsf@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
	<7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
	<7vwtpc7lju.fsf_-_@assigned-by-dhcp.cox.net>
	<20050603230234.GC13093@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 01:37:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeLj7-0008HP-4k
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 01:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFCXk0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 19:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFCXk0
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 19:40:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:45953 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261180AbVFCXkX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2005 19:40:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050603234023.HXIE7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Jun 2005 19:40:23 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050603230234.GC13093@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 4 Jun 2005 01:02:37 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'd rather see it use the correct U*MAX.

