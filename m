From: Junio C Hamano <junkio@cox.net>
Subject: Re: expensive local git clone
Date: Mon, 04 Jul 2005 16:07:41 -0700
Message-ID: <7virzqgog2.fsf@assigned-by-dhcp.cox.net>
References: <20050704204235.GE21128@pasky.ji.cz>
	<20050704.140043.112609056.davem@davemloft.net>
	<7v7jg6i72c.fsf@assigned-by-dhcp.cox.net>
	<20050704.154933.104033112.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 01:08:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpa3A-0007rB-Eb
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 01:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVGDXIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 19:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVGDXIS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 19:08:18 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:62121 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261727AbVGDXII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 19:08:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050704230741.QCOM22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 4 Jul 2005 19:07:41 -0400
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050704.154933.104033112.davem@davemloft.net> (David S. Miller's message of "Mon, 04 Jul 2005 15:49:33 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DSM" == David S Miller <davem@davemloft.net> writes:

DSM> Looks interesting.  Any particular reason to use "cpio"
DSM> instead of "cp"?

No particular reason other than I am just used to doing things
that way.
