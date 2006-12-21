From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 1.4.4.2 is giving the following errors...
Date: Wed, 20 Dec 2006 21:29:05 -0800
Message-ID: <7vwt4l24wu.fsf@assigned-by-dhcp.cox.net>
References: <ace3f33d0612202115p3fedb169pf235c4556f2eef57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 21 06:29:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxGUr-0000rG-Uj
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 06:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWLUF3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 00:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWLUF3J
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 00:29:09 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45107 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422719AbWLUF3I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 00:29:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221052905.ZAF25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 00:29:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1HUP1W00J1kojtg0000000; Thu, 21 Dec 2006 00:28:24 -0500
To: git@vger.kernel.org
In-Reply-To: <ace3f33d0612202115p3fedb169pf235c4556f2eef57@mail.gmail.com>
	(srinivas naga vutukuri's message of "Thu, 21 Dec 2006 10:45:44
	+0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35015>

"srinivas naga vutukuri" <srinivas.vutukuri@gmail.com> writes:

>       I am new to git.

Lose the CDPATH from your environment.  It's a fine variable to
have in your interactive shells, but it never makes sense to
export into your environment.
