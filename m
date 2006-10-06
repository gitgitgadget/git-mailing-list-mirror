From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] git-blame --porcelain
Date: Fri, 06 Oct 2006 02:59:36 -0700
Message-ID: <7v1wpl229j.fsf@assigned-by-dhcp.cox.net>
References: <7v4puicvz5.fsf@assigned-by-dhcp.cox.net>
	<20061006002904.24024.qmail@web31814.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 12:00:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVmUh-0005m5-5C
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 11:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWJFJ7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 05:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWJFJ7h
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 05:59:37 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53426 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751400AbWJFJ7h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 05:59:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061006095936.METT21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Oct 2006 05:59:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WxzV1V0011kojtg0000000
	Fri, 06 Oct 2006 05:59:29 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061006002904.24024.qmail@web31814.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 5 Oct 2006 17:29:04 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28395>

Luben Tuikov <ltuikov@yahoo.com> writes:

> BTW, I would've chosen to print the line number of the original file
> first, followed by the line number of the final (this) file followed
> by the number of lines in this group of the final (this) file:

Swapped them and trivially adjusted [6/6] for this change.  The
result is found in "pu".
