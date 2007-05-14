From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] user-manual: fix branch names in examples
Date: Mon, 14 May 2007 14:31:20 -0700
Message-ID: <7viravm6s7.fsf@assigned-by-dhcp.cox.net>
References: <20070514155111.GE5272@planck.djpig.de>
	<20070514160335.GA20736@fieldses.org>
	<20070514160507.GB20736@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon May 14 23:31:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hni8d-00016M-5Y
	for gcvg-git@gmane.org; Mon, 14 May 2007 23:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbXENVbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 17:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbXENVbW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 17:31:22 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55532 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbXENVbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 17:31:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514213121.NPUZ13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 17:31:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id z9XL1W0091kojtg0000000; Mon, 14 May 2007 17:31:20 -0400
In-Reply-To: <20070514160507.GB20736@fieldses.org> (J. Bruce Fields's message
	of "Mon, 14 May 2007 12:05:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47293>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Thanks to Frank Lichtenheld for pointing out inconsistent use of branch
> names in a couple examples.
>
> Add a little more example output while I'm at it.
> ...

Thanks everybody for participating in these fixups.

Bruce, how heavy is your workload these days?  Would you mind if
I ask you to collect the list comments, have me wait for a few
days until the discussions and updates settle down and give me
"Ok, all ready to be pulled" after that?
