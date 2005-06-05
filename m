From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH-CAREFUL/RENAME] rename git-rpush and git-rpull to
 git-ssh-push and git-ssh-pull
Date: Sun, 5 Jun 2005 12:06:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506051203510.30848-100000@iabervon.org>
References: <7vfyvxb89m.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 18:04:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dexbk-0001BB-Jb
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 18:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVFEQHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 12:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVFEQHe
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 12:07:34 -0400
Received: from iabervon.org ([66.92.72.58]:44805 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261587AbVFEQHa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 12:07:30 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Dexdp-000441-00; Sun, 5 Jun 2005 12:06:25 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyvxb89m.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Jun 2005, Junio C Hamano wrote:

> In preparation for 1.0 release, this make the command names
> consistent with others in git-*-pull family.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

This looks right to me (assuming git-apply produces the expected results,
of course).

Acked-by: Daniel Barkalow <barkalow@iabervon.org>


