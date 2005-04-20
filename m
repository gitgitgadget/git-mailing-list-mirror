From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Possible strategy cleanup for git add/remove/diff etc.
Date: Tue, 19 Apr 2005 18:58:55 -0700
Message-ID: <7v3btmmco0.fsf@assigned-by-dhcp.cox.net>
References: <20050419035107.GB5554@pasky.ji.cz>
	<7vacnumgot.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 03:55:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO4QV-0000aV-G0
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 03:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVDTB66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 21:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVDTB66
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 21:58:58 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42908 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261253AbVDTB65 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 21:58:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050420015855.UHIH7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 19 Apr 2005 21:58:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 19 Apr 2005 18:51:06 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Is there any other reason why git-pasky wants to have a work file?

Do you mean "why does a user wants to check things out in the
working directory and make changes, possibly run compile tests
before pushing the result to Linus?" ;-)  I'm confused what you
mean by "a work file", I guess...


