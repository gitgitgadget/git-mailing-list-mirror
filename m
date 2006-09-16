From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Sat, 16 Sep 2006 11:00:04 -0700
Message-ID: <7v8xkjadzv.fsf@assigned-by-dhcp.cox.net>
References: <20060914022404.GA900@sashak.voltaire.com>
	<7vk6475408.fsf@assigned-by-dhcp.cox.net>
	<20060916023717.GA13570@sashak.voltaire.com>
	<7vwt849nv6.fsf@assigned-by-dhcp.cox.net>
	<20060916100147.GA17504@sashak.voltaire.com>
	<7virjnafev.fsf@assigned-by-dhcp.cox.net>
	<20060916174134.GE17504@sashak.voltaire.com>
	<7vd59vae2r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 20:00:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOeSa-0001Cr-NW
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 20:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWIPSAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 14:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWIPSAI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 14:00:08 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16122 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750764AbWIPSAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 14:00:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916180005.WHGU6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 14:00:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id P6061V00X1kojtg0000000
	Sat, 16 Sep 2006 14:00:07 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <7vd59vae2r.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Sep 2006 10:58:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27123>

Junio C Hamano <junkio@cox.net> writes:

> Sasha Khapyorsky <sashak@voltaire.com> writes:
>
>> Good. Am I need to send the patch or you will integrate it?
>
> Actually, I am thinking of doing this in two steps.
>
> The attached is the first "clean-up" step, which should be
> obvious enough.
>
> And you already know what the second one that would come on top
> of this should look like ;-).

Oops, thinko.  I sent a rolled-up one out.
