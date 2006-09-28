From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] svnimport add support for parsing From lines for author
Date: Thu, 28 Sep 2006 09:10:17 -0700
Message-ID: <7vk63ovuom.fsf@assigned-by-dhcp.cox.net>
References: <20060925110813.GA4419@shadowen.org>
	<7v7izrtdtw.fsf@assigned-by-dhcp.cox.net>
	<4518DC11.5050806@shadowen.org>
	<7vfyedj2j2.fsf@assigned-by-dhcp.cox.net>
	<451BAACE.70005@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 18:13:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSyTz-0001dU-SM
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWI1QLF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWI1QKa
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:10:30 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:20617 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751328AbWI1QKS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:10:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928161018.VIFI22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 12:10:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TsAL1V00B1kojtg0000000
	Thu, 28 Sep 2006 12:10:20 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <451BAACE.70005@shadowen.org> (Andy Whitcroft's message of "Thu,
	28 Sep 2006 11:58:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28013>

Andy Whitcroft <apw@shadowen.org> writes:

> This one didn't make it onto the git.git whats next page.  Not sure of
> protocol in these matters, so I'll just ask.  Has this been rejected or
> forgotten?

Asking is always good.  It was forgotten.
