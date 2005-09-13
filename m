From: Junio C Hamano <junkio@cox.net>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 15:37:51 -0700
Message-ID: <7vwtlkvbk0.fsf@assigned-by-dhcp.cox.net>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
	<20050913211444.GA27029@mars.ravnborg.org>
	<7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
	<7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509131525250.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:45:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFJPY-0008SX-6J
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 00:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVIMWhy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 18:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbVIMWhy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 18:37:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40325 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932556AbVIMWhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 18:37:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913223751.ZESY24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 18:37:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509131525250.26803@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 13 Sep 2005 15:29:35 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8502>

Linus Torvalds <torvalds@osdl.org> writes:

> You do realize that up until a week ago (six days, to be exact),
> kernel.org was running git-0.99.4, which I don't think actually
> implemented any of the info stuff?

Ah, no I didn't.  For future reference, how can I find that kind
of thing myself (not "what was not in 0.99.4", but "what did
kernel.org run a week ago")?

> Dumb protocols can never do really well. That's just very fundamental. 

I agree.  I am waiting for git-deamon to happen on kernel.org,

I am hoping there won't be much problems but am somewhat worried
that customized packing for each client might turn out to be too
much load.
