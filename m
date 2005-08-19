From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rev-list: avoid crash on broken repository
Date: Fri, 19 Aug 2005 14:30:20 -0700
Message-ID: <7vfyt5vclv.fsf@assigned-by-dhcp.cox.net>
References: <20050819182835.GA12057@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 23:31:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6ERV-00009c-K7
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 23:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbVHSVaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 17:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVHSVaW
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 17:30:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:64944 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932712AbVHSVaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 17:30:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819213021.DQKD15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 17:30:21 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I humbly appreciate your patch, sir.  I am really sorry to be in
the position of having to tell you this, but earlier the Emperor
Penguin himself gave me this shiny blue baseball bat and told me
to show it to any deserving person.  Could you please come
closer and kindly extend your neck a little bit more, so I can
swing it well at your head...

  Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
  Date: Wed, 17 Aug 2005 13:42:57 -0700
  Message-ID: <7vfyt8thv2.fsf@assigned-by-dhcp.cox.net>

  Linus Torvalds <torvalds@osdl.org> writes:

  > ...
  > Ergo: if somebody sends you mime-encoded patches, hit them
  > with a baseball bat (politely) and teach them not to do
  > that...

  I agree with you in principle and that is why I always run
  applymbox with the -q flag.  Maybe I should start trying the
  baseball bat approach to see what happens.

;-)

Anyway, I have merged your fix and pushed it out.  Thanks for
the patch.
