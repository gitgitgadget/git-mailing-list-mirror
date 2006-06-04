From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 4 Jun 2006 11:51:58 +1000
Message-ID: <17538.15550.732964.349428@cargo.ozlabs.ibm.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<17537.32585.260926.48759@cargo.ozlabs.ibm.com>
	<7vy7wedvyx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 04:00:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmhuI-0005jU-4S
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 03:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWFDB7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 21:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWFDB7u
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 21:59:50 -0400
Received: from ozlabs.org ([203.10.76.45]:59585 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751299AbWFDB7u (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 21:59:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 194F167A2E; Sun,  4 Jun 2006 11:59:49 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7wedvyx.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21239>

Junio C Hamano writes:

> That would be useful I think.

Done.  It was pretty easy with the infrastructure for doing the tags
in place.

> Yes, but I rarely if ever pull "next" as a whole into "master".

I see.  In that case it probably would be good if you pulled the gitk
"new" branch into "next".

Paul.
