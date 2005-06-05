From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] git-daemon server
Date: Sun, 5 Jun 2005 01:38:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506050132590.30848-100000@iabervon.org>
References: <7vk6l9flzr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 07:36:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dennt-0006kp-Qw
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 07:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVFEFjX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 01:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVFEFjX
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 01:39:23 -0400
Received: from iabervon.org ([66.92.72.58]:38663 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261452AbVFEFjU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 01:39:20 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Denpy-0003mp-00; Sun, 5 Jun 2005 01:38:18 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6l9flzr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Jun 2005, Junio C Hamano wrote:

> I'd like to see your "-w" extention merged into mainline soon
> (both push and pull).

I have the patches worked out now, and I'm planning to send them on
Monday.

> BTW, don't we want to have them renamed to git-ssh-pull (and
> git-ssh-push) for consistency with other transports, before 1.0
> happens?

I think that would be good, but I'm still using a really old version of
git for my development, so I don't have your diff rename support; could
you send a patch to do it?

	-Daniel
*This .sig left intentionally blank*

