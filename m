From: Junio C Hamano <junkio@cox.net>
Subject: GIT 0.99.8f
Date: Wed, 19 Oct 2005 03:04:06 -0700
Message-ID: <7v4q7dakmh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964780AbVJSKEJ@vger.kernel.org Wed Oct 19 12:05:06 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964780AbVJSKEJ@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESAo9-0007q9-Ts
	for glk-linux-kernel-3@gmane.org; Wed, 19 Oct 2005 12:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVJSKEJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 19 Oct 2005 06:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVJSKEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 06:04:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:47050 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964776AbVJSKEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 06:04:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019100344.WSGB29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 06:03:44 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10282>

GIT 0.99.8f is available as usual at:

    RPMs and tarball: www.kernel.org:/pub/software/scm/git/
    Debs and tarball: www.kernel.org:/pub/software/scm/git/debian/

Sorry, I said 0.99.8e was going to be the last 0.99.8
maintenance release, but it turns out that there was a flurry of
updates to git-daemon and rev-list (which matters to gitweb)
yesterday.  So here it is.

Now, this _is_ going to be the last 0.99.8 maintenance release,
I promise ;-).
