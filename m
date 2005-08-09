From: Junio C Hamano <junkio@cox.net>
Subject: Re: use of temporary refs in resolve
Date: Tue, 09 Aug 2005 05:51:48 -0700
Message-ID: <7vy87bw9wb.fsf@assigned-by-dhcp.cox.net>
References: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
	<tnxk6iwx161.fsf@arm.com> <7vfytkdcgm.fsf@assigned-by-dhcp.cox.net>
	<tnxr7d4vi5v.fsf@arm.com> <7v1x53zuyv.fsf@assigned-by-dhcp.cox.net>
	<tnxmznr32cy.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 14:51:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2TaF-0000hS-Pf
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 14:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVHIMvu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 08:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVHIMvu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 08:51:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57738 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932526AbVHIMvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 08:51:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809125149.LWJ1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 Aug 2005 08:51:49 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <tnxmznr32cy.fsf@arm.com> (Catalin Marinas's message of "Tue, 09
	Aug 2005 10:07:25 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> If you plan to implement multiple values in FETCH_HEAD, StGIT won't be
> able to use this since it doesn't do any merging for the base of the
> stack. As I said above, this is not a problem and I was probably wrong
> when decided to use git-fetch-script directly and not git-pull-script.
>
> Please let me know if you need more info.

Thanks.  Perfectly clear.
