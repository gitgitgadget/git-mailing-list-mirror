From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Ensure test-genrandom availability for t5301/t5302
Date: Sat, 28 Apr 2007 15:48:39 -0700
Message-ID: <7vodl8i08o.fsf@assigned-by-dhcp.cox.net>
References: <4633A47A.4020508@cswitch.com>
	<7v3b2kjfji.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510704281536u5b5751a0k504a5ec0f8a36cf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 00:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhvif-0008Rx-Cw
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 00:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311AbXD1Wsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 18:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754333AbXD1Wsm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 18:48:42 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57673 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbXD1Wsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 18:48:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428224841.IIER16514.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Apr 2007 18:48:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id smof1W00C1kojtg0000000; Sat, 28 Apr 2007 18:48:40 -0400
In-Reply-To: <56b7f5510704281536u5b5751a0k504a5ec0f8a36cf7@mail.gmail.com>
	(Dana How's message of "Sat, 28 Apr 2007 15:36:54 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45801>

"Dana How" <danahow@gmail.com> writes:

> Either way is fine with me.
> I just don't want any one to have the nasty surprise I had --
> fortunately I figured it out quickly.
>
> So you will apply your patch?

Perhaps.  I've known about this for some time, but it is usually
not a problem if you do "make test" from the toplevel, hence it
was a low priority for me.
