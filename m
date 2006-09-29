From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Add snapshot to log; remove redundant commit from log
Date: Thu, 28 Sep 2006 19:29:01 -0700
Message-ID: <7vven7pfrm.fsf@assigned-by-dhcp.cox.net>
References: <20060928235050.63085.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 04:29:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT87r-0006bt-LP
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 04:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWI2C3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 22:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWI2C3I
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 22:29:08 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:65466 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030391AbWI2C3D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 22:29:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929022902.IFKD16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 22:29:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id U2V41V00K1kojtg0000000
	Thu, 28 Sep 2006 22:29:04 -0400
To: ltuikov@yahoo.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28086>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Adding "snapshot" without removing redundant "commit" makes
> it too messy as the log gets out of visual alignment.
>
> I'm ambivalent whether this goes in or not.

I admit I was who suggested "we might want to", but I agree this
is going a bit too far.
