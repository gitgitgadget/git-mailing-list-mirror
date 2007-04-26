From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/5] RFC: for_each_revision() helper
Date: Thu, 26 Apr 2007 14:21:46 -0700
Message-ID: <7vk5vysufp.fsf@assigned-by-dhcp.cox.net>
References: <11776168001253-git-send-email-lcapitulino@mandriva.com.br>
	<7vr6q6svkc.fsf@assigned-by-dhcp.cox.net>
	<20070426181420.4db235cc@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:22:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBPp-0006Vo-I6
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbXDZVVt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbXDZVVt
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:21:49 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38496 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbXDZVVs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:21:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070426212147.BYYC1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Apr 2007 17:21:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id rxMm1W00e1kojtg0000000; Thu, 26 Apr 2007 17:21:47 -0400
In-Reply-To: <20070426181420.4db235cc@localhost> (Luiz Fernando
	N. Capitulino's message of "Thu, 26 Apr 2007 18:14:20 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45660>

"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
writes:

> Em Thu, 26 Apr 2007 13:57:23 -0700
> Hermes Trismegisto <junkio@cox.net> escreveu:
>
> | Luiz Fernando N Capitulino <lcapitulino@mandriva.com.br> writes:
> | 
> | >  [This' also a git-send-email test, so, if this fail by showing just
> | >   the first e-mail in the series, do not blame me :)]
> | 
> | But if you changed your name to omit '.', that is not much of a
> | test I suspect...
>
>  Yes, I did. But git-send-email is taking my name from the patches,
> so the same problem happened.
>
>  I had to change my name in the patches to make it to work.

I know.  But my point of "changing your name is not much of a
test" is that that was exactly what Robin Johnson's patches to
quote CC: addresses that were taken from the sign-off lines in
the proposed commit log message were meant to fix.

Specifically:

http://repo.or.cz/w/alt-git.git?a=commitdiff;h=732263d411fe2e3e29ee9fa1c2ad1a20bdea062c
