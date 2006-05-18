From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Thu, 18 May 2006 15:53:36 -0700
Message-ID: <7vsln7lzbj.fsf@assigned-by-dhcp.cox.net>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth>
	<Pine.LNX.4.64.0605181435230.10823@g5.osdl.org>
	<7viro3nh07.fsf@assigned-by-dhcp.cox.net>
	<20060518222045.GB6535@nowhere.earth>
	<20060518225216.GC6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 00:53:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgrNF-0007vT-NX
	for gcvg-git@gmane.org; Fri, 19 May 2006 00:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWERWxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWERWxi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 18:53:38 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26267 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751057AbWERWxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 18:53:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518225336.ODGC9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 18:53:36 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060518225216.GC6535@nowhere.earth> (Yann Dirson's message of
	"Fri, 19 May 2006 00:52:16 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20314>

Yann Dirson <ydirson@altern.org> writes:

> To make my point maybe more clear: if someone really wants to make a
> graft permanent, wouldn't some history rewriting ... be the
> way to go,...

Yes.
