From: Junio C Hamano <junkio@cox.net>
Subject: Unresolved issues #4
Date: Thu, 05 Oct 2006 23:26:46 -0700
Message-ID: <7vfye20xjt.fsf@assigned-by-dhcp.cox.net>
References: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 06 08:26:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVjAZ-0006Mh-FV
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 08:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWJFG0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 02:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWJFG0s
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 02:26:48 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:44241 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161012AbWJFG0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 02:26:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061006062646.RFQJ18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 6 Oct 2006 02:26:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WuSp1V00B1kojtg0000000
	Fri, 06 Oct 2006 02:26:49 -0400
To: git@vger.kernel.org
In-Reply-To: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 17 Aug 2006 21:09:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28388>

Recent issues I am aware of but haven't kept track of closely
enough and as a result do not have a clue about X-<.

From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Notes on Using Git with Subprojects
Message-ID: <45196628.9010107@gmail.com>

[jc: a very nice write-up of a subprojects workflow. I do not
 remember if it produced any actionable items, though]

From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Message-ID: <450EABD0.1040102@innova-card.com>

Repeated requests against git-daemon makes it stuck

[jc: does not reproduce easily for me; has anybody seen it?]

From: Shawn Pearce <spearce@spearce.org>
Message-ID: <20060926215745.GC8177@spearce.org>

git-mirror (reverse of git-push --all).

[jc: any progress?]

From: Junio C Hamano <junkio@cox.net>
Message-ID: <7v7izrzpk2.fsf@assigned-by-dhcp.cox.net>

Deal with rfc2822-invalid author mail address in send-email.

[jc: forgot to apply?]

From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 8/6] let the GIT native protocol use offsets to delta base when

[jc: applied all but I suspect git-push side hasn't been converted?]

From: Shawn Pearce <spearce@spearce.org>
Message-ID: <20060930045037.GB18479@spearce.org>

"git ref-log" command to interact with ref-log?

[jc: not much interest from users?]

From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Message-ID: <4523EC14.6070806@s5r6.in-berlin.de>

AsciiDoc 8 does not grok documents written for AsciiDoc 7 out of
the box.

[jc: status?]

From:	Josh Triplett <josh@freedesktop.org>
Message-ID: <451A30E4.50801@freedesktop.org>

git-split

[jc: no response to the initial review comments]
