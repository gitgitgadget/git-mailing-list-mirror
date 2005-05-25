From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow dot files in ls-files as well.
Date: Tue, 24 May 2005 18:06:50 -0700
Message-ID: <7v8y24ru51.fsf@assigned-by-dhcp.cox.net>
References: <7vhdgstb7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241723060.2307@ppc970.osdl.org>
	<7v8y24taai.fsf@assigned-by-dhcp.cox.net>
	<7v1x7wt9qm.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241753300.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 03:06:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DakKq-0006pG-SH
	for gcvg-git@gmane.org; Wed, 25 May 2005 03:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVEYBG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 21:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVEYBG4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 21:06:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60124 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262224AbVEYBGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 21:06:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525010650.OJGX7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 21:06:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241753300.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 17:54:33 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> You really _do_ want to strip out the ".git" file.

Yes I do, but not probably hardcoded ".git".

