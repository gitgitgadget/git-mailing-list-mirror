From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch question
Date: Sun, 28 May 2006 13:35:31 -0700
Message-ID: <7vpshxdh0s.fsf@assigned-by-dhcp.cox.net>
References: <m2odxikktm.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 28 22:35:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkRz6-0002Qz-QU
	for gcvg-git@gmane.org; Sun, 28 May 2006 22:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWE1Ufe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 16:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWE1Ufd
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 16:35:33 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:26772 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750932AbWE1Ufd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 16:35:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060528203532.QUR27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 May 2006 16:35:32 -0400
To: Seth Falcon <sethfalcon@gmail.com>
In-Reply-To: <m2odxikktm.fsf@ziti.fhcrc.org> (Seth Falcon's message of "Sun,
	28 May 2006 12:31:33 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20891>

Seth Falcon <sethfalcon@gmail.com> writes:

> 1. When is one supposed to use --signoff?  I gather the answer is
>    project specific, but a statement of what's expected for git
>    itself would probably help clarify things for me.

You shouldn't ;-).  Rather, you should sign-off when you make a
commit, or if you are forwarding somebody else's patch, before
you send the e-mail off.  

> 2. How should I add extra notes to an email generated using
>    git-format-patch?  Is this in the docs somewhere that I missed?  Is
>    there a recommended way to do this?

Read the format-patch output in your e-mail buffer and edit just
like you edit any text you write in your e-mail.
