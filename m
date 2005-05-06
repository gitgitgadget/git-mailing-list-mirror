From: Junio C Hamano <junkio@cox.net>
Subject: Quick command reference
Date: Thu, 05 May 2005 23:30:10 -0700
Message-ID: <7vhdhgeuj1.fsf@assigned-by-dhcp.cox.net>
References: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>
	<4274EB3D.2060602@dgreaves.com> <4274F373.6030001@khandalf.com>
	<4274FB3F.8090206@dgreaves.com>
	<Pine.LNX.4.58.0505010927040.2296@ppc970.osdl.org>
	<42750D06.70004@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Greaves <david@dgreaves.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 08:24:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTwFi-0006jp-Bd
	for gcvg-git@gmane.org; Fri, 06 May 2005 08:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVEFGad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 02:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVEFGad
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 02:30:33 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:51626 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261156AbVEFGaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 02:30:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050506063009.MJWY7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 May 2005 02:30:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <42750D06.70004@dgreaves.com> (David Greaves's message of "Sun,
 01 May 2005 18:08:22 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, please pull from git-jc.git archive at:

    http://members.cox.net/junkio/git-jc.git/

(this time I have refs/heads/master there as well as HEAD; sorry
but no rsync).

I've added the Documentation directory as you suggested and
placed the copy of Quick reference David Greaves has been
working on.  I've minimally copy edited it to match the current
command names after the big git-* renaming, and also added
descriptions of commands and scripts that was missing back
then.  These three steps are recorded as separate commits (in
sequence, not Octopus).

The format is still plain text.  AsciiDoc can come in the next
round, but let's get the ball rolling by putting something in
there.

Please note that I do not intend to take the document over from
David.  I am just trying to help him get the result of his
effort into the mainline so that the document helps wider
audience, and to encourage (and remind) patch writers to keep it
up to date when modifying the Plumbing.

