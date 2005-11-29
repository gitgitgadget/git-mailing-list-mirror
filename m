From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix typo in http-push.c
Date: Mon, 28 Nov 2005 22:03:30 -0800
Message-ID: <7vbr04ng7h.fsf@assigned-by-dhcp.cox.net>
References: <20051129005154.GA3076@pitr.home.jan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 07:22:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgyaY-0004c3-Ak
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 07:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVK2GDd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 01:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVK2GDd
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 01:03:33 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:40595 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751312AbVK2GDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 01:03:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129060332.SBFS25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 01:03:32 -0500
To: Jan Andres <jandres@gmx.net>
In-Reply-To: <20051129005154.GA3076@pitr.home.jan> (Jan Andres's message of
	"Tue, 29 Nov 2005 01:51:54 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12921>

Jan Andres <jandres@gmx.net> writes:

> Please find below the patch for a typo in http-push.c (in the maint
> branch), which caused git-http-push to segfault on my Linux i386 box.

Thanks.  Next time around please sign-off your patches (see
Documentation/SubmittingPatches).
