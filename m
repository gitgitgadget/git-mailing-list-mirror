From: Junio C Hamano <junkio@cox.net>
Subject: Re: Am I doing something wrong?
Date: Wed, 21 Dec 2005 09:52:12 -0800
Message-ID: <7v3bkmcp83.fsf@assigned-by-dhcp.cox.net>
References: <86k6dyxuke.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 18:54:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep88V-0007Yp-2A
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 18:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVLURwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 12:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVLURwO
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 12:52:14 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:988 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751145AbVLURwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 12:52:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221175131.ZVHM3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 12:51:31 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86k6dyxuke.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "21 Dec 2005 08:51:13 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13883>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> localhost:~/MIRROR/git-GIT % cg-fetch
> Recovering from a previously interrupted fetch...

Sorry, I do not know what Cogito is doing there (the message is
from an "echo" in cg-fetch).  git-clone over HTTP seems to work
for me, and I just tried git-fetch over HTTP in my random
back-up repo that happened to be at around 0.99.9g without
problems, so I am reasonably sure the public repository is not
corrupt.
