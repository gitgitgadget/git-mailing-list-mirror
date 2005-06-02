From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-tar-tree: add a test case (resent)
Date: Thu, 02 Jun 2005 13:05:36 -0700
Message-ID: <7v64ww34of.fsf@assigned-by-dhcp.cox.net>
References: <20050602185046.GA3717@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 22:03:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddvty-00066K-Dw
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 22:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFBUFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVFBUFm
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 16:05:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48024 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261312AbVFBUFi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2005 16:05:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050602200537.IJZQ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Jun 2005 16:05:37 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20050602185046.GA3717@lsrfire.ath.cx> (Rene Scharfe's message
 of "Thu, 2 Jun 2005 20:50:46 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I like the test but suspect it belongs to t5000 series according
to the numbering scheme Pasky originaly did.

