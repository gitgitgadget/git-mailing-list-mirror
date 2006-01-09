From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 08 Jan 2006 22:46:06 -0800
Message-ID: <7vlkxpucep.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A136DD@hdsmsx401.amr.corp.intel.com>
	<46a038f90601082208i95cd19fmda542da0da8cc9ef@mail.gmail.com>
	<Pine.LNX.4.64.0601082212420.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 07:46:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvqnJ-0002zZ-Ce
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 07:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbWAIGqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 01:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932911AbWAIGqM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 01:46:12 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56733 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932907AbWAIGqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 01:46:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109064456.WDZI20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 01:44:56 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601082212420.3169@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 8 Jan 2006 22:13:49 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14359>

Linus Torvalds <torvalds@osdl.org> writes:

> To be fair, backtracking a "git-rebase" isn't obvious. One of the 
> downsides of rebasing.

I thought "git reset --hard ORIG_HEAD" as usual would do.
