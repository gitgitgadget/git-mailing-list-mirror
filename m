From: Junio C Hamano <junkio@cox.net>
Subject: Re: openbsd version?
Date: Mon, 10 Oct 2005 12:06:15 -0700
Message-ID: <7vvf0542fs.fsf@assigned-by-dhcp.cox.net>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 21:09:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP2ya-0006kf-BD
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 21:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVJJTGR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 15:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVJJTGR
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 15:06:17 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48876 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751117AbVJJTGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 15:06:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010190601.BUMK29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 15:06:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510100939320.14597@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 10 Oct 2005 09:41:05 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9913>

Linus Torvalds <torvalds@osdl.org> writes:

> Either do
>
> 	make NO_STRCASESTR=1 ..
>
> or add that explicitly to the makefile in the OpenBSD rules and send Junio 
> a tested patch ;)

Thanks; this has been resolved underwater.
