From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git web broken, or Linus' kernel tree in odd state
Date: Sat, 15 Apr 2006 12:15:59 -0700
Message-ID: <7v8xq6fy4w.fsf@assigned-by-dhcp.cox.net>
References: <12c511ca0604151155j40c68a21qf684f77d2476605b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 21:16:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUqFZ-0003iZ-DE
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 21:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWDOTQB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWDOTQB
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 15:16:01 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:19130 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751268AbWDOTQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 15:16:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415191600.QMQM20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 15:16:00 -0400
To: "Tony Luck" <tony.luck@intel.com>
In-Reply-To: <12c511ca0604151155j40c68a21qf684f77d2476605b@mail.gmail.com>
	(Tony Luck's message of "Sat, 15 Apr 2006 11:55:55 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18760>

"Tony Luck" <tony.luck@intel.com> writes:

> Git web is showing the "master" tag four commits back from HEAD on
> the summary page for Linus' kernel tree, which is unusual (isn't it?).

I suspect it is related to this:

http://article.gmane.org/gmane.comp.version-control.git/14366
