From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-send-mail in sh
Date: Mon, 28 Nov 2005 01:34:12 -0800
Message-ID: <7v64qdxgiz.fsf@assigned-by-dhcp.cox.net>
References: <4386DD45.6030308@op5.se>
	<20051125163358.GF16995@mythryan2.michonline.com>
	<43874415.8040302@op5.se> <438A5401.3070008@michonline.com>
	<438AC7A0.7030407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 28 10:35:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgfOv-0006IO-9x
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 10:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVK1JeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 04:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVK1JeO
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 04:34:14 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53725 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750927AbVK1JeN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 04:34:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128093344.WVVS3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 04:33:44 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <438AC7A0.7030407@op5.se> (Andreas Ericsson's message of "Mon, 28
	Nov 2005 10:02:24 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12867>

Andreas Ericsson <ae@op5.se> writes:

> By "local" do you mean "local on Junio's laptop" or "local at cox.net"?
>
> "mail" uses the "local on Junio's laptop" SMTP server so he can 
> configure it any way he wants.

I am puzzled.  What if I do not run any SMTP server on the
laptop and use ISP's SMTP server?  Right now my ISP's SMTP
server does not seem to require AUTH, so it is not an issue for
me, though..
