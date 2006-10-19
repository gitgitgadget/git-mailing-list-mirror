From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't use $author_name undefined when $from contains no /\s</.
Date: Thu, 19 Oct 2006 09:19:52 -0700
Message-ID: <7vbqo8uvkn.fsf@assigned-by-dhcp.cox.net>
References: <87vemgn1s2.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 18:20:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gaacg-0005It-BJ
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 18:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946187AbWJSQTy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 12:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946191AbWJSQTy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 12:19:54 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:27631 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1946187AbWJSQTx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 12:19:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061019161953.IHWK12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Oct 2006 12:19:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cGKw1V00F1kojtg0000000
	Thu, 19 Oct 2006 12:19:56 -0400
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87vemgn1s2.fsf@rho.meyering.net> (Jim Meyering's message of
	"Thu, 19 Oct 2006 10:33:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29368>

Jim Meyering <jim@meyering.net> writes:

> I noticed a case not handled in a recent patch.

Thanks. Will apply.

Curiously your patch was whitespace damaged.
