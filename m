From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove misguided branch disambiguation.
Date: Sat, 17 Dec 2005 19:03:33 -0800
Message-ID: <7v4q57yum2.fsf@assigned-by-dhcp.cox.net>
References: <7virto12u5.fsf@assigned-by-dhcp.cox.net>
	<20051218000636.GA20874@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 04:05:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Enopn-00057s-3M
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 04:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbVLRDDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 22:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVLRDDg
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 22:03:36 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41660 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932674AbVLRDDf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 22:03:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051218030241.YQZL6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 22:02:41 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051218000636.GA20874@steel.home> (Alex Riesen's message of
	"Sun, 18 Dec 2005 01:06:36 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13787>

Alex Riesen <raa.lkml@gmail.com> writes:

> Right. The test 'Ambiguous' in t0000-basic is redundant now, btw

I reverted that in jc/tail branch (part of pu branch) as well.
