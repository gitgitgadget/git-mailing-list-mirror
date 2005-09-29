From: Junio C Hamano <junkio@cox.net>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 28 Sep 2005 22:13:54 -0700
Message-ID: <7vd5mso3ql.fsf@assigned-by-dhcp.cox.net>
References: <433B3B10.5050407@zytor.com>
	<46a038f905092821462d08f86a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 07:14:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKqk4-0001BI-26
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 07:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVI2FN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 01:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVI2FN5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 01:13:57 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62616 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751226AbVI2FN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 01:13:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929051354.MQER9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 01:13:54 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905092821462d08f86a@mail.gmail.com> (Martin Langhoff's
	message of "Thu, 29 Sep 2005 16:46:51 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9464>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Is there a way to get gitweb to "compare" branches using git-cherry? I
> often look at branches via git-web and it's impossible to tell what
> makes them unique...

Now that you mention it, I felt that too.  Maybe git-show-branch
output could help somehow?
