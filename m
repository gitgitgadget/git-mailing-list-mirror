From: Junio C Hamano <junkio@cox.net>
Subject: Re: Storing permissions
Date: Sat, 16 Apr 2005 16:42:10 -0700
Message-ID: <7vk6n247cd.fsf@assigned-by-dhcp.cox.net>
References: <20050416230058.GA10983@ucw.cz>
	<20050416161935.0d2cf3b0.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Mares <mj@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 01:38:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwrx-0005Cq-45
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDPXmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVDPXmO
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:42:14 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55503 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261202AbVDPXmM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 19:42:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416234212.LJAK19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 19:42:12 -0400
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050416161935.0d2cf3b0.pj@sgi.com> (Paul Jackson's message of
 "Sat, 16 Apr 2005 16:19:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PJ" == Paul Jackson <pj@sgi.com> writes:

PJ> That matches my experience - store 1 bit of mode state - executable or not.

Sounds like svn ;-).

