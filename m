From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git does not use GIT_* envirnment vars?
Date: Thu, 26 May 2005 23:47:26 -0700
Message-ID: <7vmzqh17y9.fsf@assigned-by-dhcp.cox.net>
References: <200505270109.44302.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 08:47:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbYb3-0006gm-7u
	for gcvg-git@gmane.org; Fri, 27 May 2005 08:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVE0Gra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 02:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVE0Gra
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 02:47:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38899 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261899AbVE0Gr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 02:47:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527064726.NUMU23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 02:47:26 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <200505270109.44302.dtor_core@ameritech.net> (Dmitry Torokhov's
 message of "Fri, 27 May 2005 01:09:44 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am baffled.  If you are a bash user, what does "type --all"
tells you?  The only explanation I can think of is that you
might have leftover old git-* installation somewhere on your
PATH.


