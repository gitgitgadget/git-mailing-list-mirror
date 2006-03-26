From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-explode-packs
Date: Sat, 25 Mar 2006 22:12:46 -0800
Message-ID: <7vwtehpwdd.fsf@assigned-by-dhcp.cox.net>
References: <11432881443149-git-send-email-matlads@dsmagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 08:12:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNOUd-0001Q2-UR
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 08:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWCZGMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 01:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWCZGMs
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 01:12:48 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61414 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750735AbWCZGMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 01:12:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060326061247.UXNZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Mar 2006 01:12:47 -0500
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <11432881443149-git-send-email-matlads@dsmagic.com> (Martin
	Atukunda's message of "Sat, 25 Mar 2006 15:02:24 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18029>

Martin Atukunda <matlads@dsmagic.com> writes:

> This script does the opposite of git repack -a -d.

The script seems to do what it claims to, but now why would one
need to use this?  In other words what's the situation one would
find this useful?
