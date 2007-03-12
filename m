From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git-diff -p :/anything" always segfaults
Date: Mon, 12 Mar 2007 11:42:11 -0700
Message-ID: <7vzm6is3r0.fsf@assigned-by-dhcp.cox.net>
References: <87d53fsjiz.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0703111322180.9690@woody.linux-foundation.org>
	<7vslcbv6ol.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703120900300.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:42:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpTM-0001zO-IG
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 19:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbXCLSmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 14:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXCLSmN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 14:42:13 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61560 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbXCLSmM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 14:42:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312184212.MRHJ24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 12 Mar 2007 14:42:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZuiB1W00P1kojtg0000000; Mon, 12 Mar 2007 14:42:11 -0400
In-Reply-To: <Pine.LNX.4.64.0703120900300.9690@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 12 Mar 2007 09:14:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42058>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Your version is *also* buggy.

You are right.

Applied, and thanks.
