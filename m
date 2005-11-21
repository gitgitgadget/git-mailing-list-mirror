From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pure renames/copies
Date: Mon, 21 Nov 2005 11:31:18 -0800
Message-ID: <7vu0e5re61.fsf@assigned-by-dhcp.cox.net>
References: <87hda61a80.fsf@gmail.com>
	<Pine.LNX.4.64.0511211020130.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 20:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeHNr-0006gk-5p
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVKUTbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKUTbU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:31:20 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24712 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932192AbVKUTbT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 14:31:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121193039.LFHM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 14:30:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511211020130.13959@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 21 Nov 2005 10:37:10 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12473>

Linus Torvalds <torvalds@osdl.org> writes:

> Of course, arguably "-M100" should really do this optimization for you. 
> Junio?

I'd agree.  That is what -M100 should mean.
