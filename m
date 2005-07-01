From: Junio C Hamano <junkio@cox.net>
Subject: Re: OOPS: unnumbered patch series
Date: Fri, 01 Jul 2005 00:01:50 -0700
Message-ID: <7vvf3vvwkh.fsf@assigned-by-dhcp.cox.net>
References: <2cfc40320506302334357a9f29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 01 08:57:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoFST-0006ET-IU
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 08:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbVGAHEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 03:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbVGAHD6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 03:03:58 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56057 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S263261AbVGAHBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 03:01:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050701070151.VMKZ17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 1 Jul 2005 03:01:51 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc40320506302334357a9f29@mail.gmail.com> (Jon Seymour's message of "Fri, 1 Jul 2005 16:34:22 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

JS> Junio: this is an example where the special case would be good.

I do not think -n would number [PATCH 1/1].  Please try it and
complain loudly if that does not work for you.
