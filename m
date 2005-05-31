From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] ls-tree: remove trailing slashes properly.
Date: Tue, 31 May 2005 16:22:09 -0700
Message-ID: <7v4qcjvv4u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505310827330.1876@ppc970.osdl.org>
	<7vvf4zvzfw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:20:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdG1H-0001Xp-Fv
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 01:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVEaXWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 19:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVEaXWN
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 19:22:13 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35581 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261185AbVEaXWL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 19:22:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531232209.HWQF22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 19:22:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505311507010.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 31 May 2005 15:19:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Should we do the same for git-ls-files?

