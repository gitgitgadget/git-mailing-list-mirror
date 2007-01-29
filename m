From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sun, 28 Jan 2007 16:52:00 -0800
Message-ID: <7vsldubqof.fsf@assigned-by-dhcp.cox.net>
References: <20070127062826.GE14205@fieldses.org>
	<20070128002246.GA10179@moooo.ath.cx>
	<Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
	<20070128013452.GA11244@moooo.ath.cx>
	<Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
	<20070128233445.GD12125@fieldses.org>
	<Pine.LNX.4.64.0701281549070.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 29 01:52:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBKkp-0004Ia-Og
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 01:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbXA2AwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 19:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932991AbXA2AwE
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 19:52:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59559 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932989AbXA2AwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 19:52:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070129005201.XSTV9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 19:52:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Gor21W00e1kojtg0000000; Sun, 28 Jan 2007 19:51:03 -0500
In-Reply-To: <Pine.LNX.4.64.0701281549070.3611@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 28 Jan 2007 15:49:31 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38059>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 28 Jan 2007, J. Bruce Fields wrote:
>> 
>> While we're at it, is there any need for the "objects" in
>> git-fsck-objects?
>
> Not really. We should probably just add that alias too.

Done.
