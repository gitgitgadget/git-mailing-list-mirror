From: Junio C Hamano <junkio@cox.net>
Subject: Re: Removal of "--merge-order"?
Date: Fri, 24 Feb 2006 11:25:24 -0800
Message-ID: <7v8xs0a7a3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 20:25:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCiZM-0000R9-CN
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 20:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWBXTZd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 14:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWBXTZd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 14:25:33 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:7070 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932434AbWBXTZc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 14:25:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224192411.IZZL15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 14:24:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602240824110.3771@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 24 Feb 2006 08:32:43 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16730>

Linus Torvalds <torvalds@osdl.org> writes:

> In other words, I'd really prefer if it was gone. Some of the things I 
> might do to git-rev-list would be much simpler if I didn't have to worry 
> about merge-order, and the way it interfaces with the rest of 
> git-rev-list.
>
> Comments?
>
> 			Linus

I am really glad you brought it up.  I would not miss it at all.
