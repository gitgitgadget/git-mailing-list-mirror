From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Remove unused index tracking code.
Date: Thu, 19 Oct 2006 19:30:27 -0700
Message-ID: <7vd58nra64.fsf@assigned-by-dhcp.cox.net>
References: <1168a0313ac1152d43731965fbbb6d4ccfd865a1.1161301889.git.jaharkes@cs.cmu.edu>
	<20061020002048.GC7162@delft.aura.cs.cmu.edu>
	<Pine.LNX.4.64.0610192058130.1971@xanadu.home>
	<20061020022723.GE7162@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 04:30:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gak9Y-0005er-35
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 04:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946836AbWJTCa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 22:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946835AbWJTCa3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 22:30:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:29582 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1946836AbWJTCa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 22:30:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020023028.HSAX18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Oct 2006 22:30:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cSWX1V0051kojtg0000000
	Thu, 19 Oct 2006 22:30:31 -0400
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20061020022723.GE7162@delft.aura.cs.cmu.edu> (Jan Harkes's
	message of "Thu, 19 Oct 2006 22:27:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29402>

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> I guess I'll grep through the mailinglists to try to figure out what
> these OFS and REF deltas are and why they behave so differently
> depending on their order in the pack.

It's been cooking in "next" branch for quite a while.
