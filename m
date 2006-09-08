From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move color option parsing out of diff.c and into color.[ch]
Date: Fri, 08 Sep 2006 14:19:18 -0700
Message-ID: <7vpse6gip5.fsf@assigned-by-dhcp.cox.net>
References: <20060908073452.GA25343@coredump.intra.peff.net>
	<20060908080318.GA3771@coredump.intra.peff.net>
	<7vk64eivzj.fsf@assigned-by-dhcp.cox.net>
	<20060908091206.GA5758@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 23:19:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLnkX-0004wK-0n
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 23:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWIHVSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 17:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWIHVSx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 17:18:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8119 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751261AbWIHVSx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 17:18:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908211852.BDPQ6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Sep 2006 17:18:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id KxJt1V0061kojtg0000000
	Fri, 08 Sep 2006 17:18:53 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060908091206.GA5758@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 8 Sep 2006 05:12:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26710>

Jeff King <peff@peff.net> writes:

> I'm assuming you can mark both of those up yourself rather than having
> me resend?

Sure, that's easy enough.

Thanks for the patch.
