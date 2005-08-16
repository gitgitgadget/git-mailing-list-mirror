From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 17:12:02 -0700
Message-ID: <7vll32viy5.fsf@assigned-by-dhcp.cox.net>
References: <46a038f9050814235140877be7@mail.gmail.com>
	<7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
	<46a038f90508150037f128d6@mail.gmail.com>
	<7vacjj3968.fsf@assigned-by-dhcp.cox.net>
	<46a038f905081501301bd9a801@mail.gmail.com>
	<7vr7cv1t89.fsf@assigned-by-dhcp.cox.net>
	<46a038f9050815020511574e3d@mail.gmail.com>
	<46a038f9050815042036616b08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 02:13:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4p44-0004QB-QH
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 02:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVHPAMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 20:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVHPAMF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 20:12:05 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42744 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965044AbVHPAME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 20:12:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816001204.MUXO12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 20:12:04 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> writes:

> So this patch is obsolete too. 

I take it to mean that it should be dropped and replaced with
the one you sent today with -kk change.

However, the -kk change one is a corrupted patch and does not
apply.  Your MUA ate leading whitespaces, perhaps.

I have already slurped in other two patches to cvsimport in the
proposed updates branch, so could you kindly proofread them (I
am no expert on cvs networking protocol issues) and rebase the
-kk patch, and send it without whitespace corruption this time
around please?

-jc
