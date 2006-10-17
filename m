From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] be more vim-ish, and also syntax hilight Signed-off-by lines.
Date: Tue, 17 Oct 2006 00:46:12 -0700
Message-ID: <7vodsbmlkr.fsf@assigned-by-dhcp.cox.net>
References: <11610450702261-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 17 09:46:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZjeS-0004bA-Lz
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 09:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWJQHqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 03:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWJQHqO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 03:46:14 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51629 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750827AbWJQHqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 03:46:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017074613.GTMO6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 03:46:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bKm01V0041kojtg0000000
	Tue, 17 Oct 2006 03:46:00 -0400
To: Pierre Habouzit <madcoder@debian.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29030>

I'd prefer patches to contrib/ sections to be CC'ed to the
owners of them (in this case that would be Jeff King) to be
Acked, since I do not actively maintain anything under contrib/
myself.

Jeff, are you Ok with Pierre's two patches?
