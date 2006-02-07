From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git diff a..b" broken
Date: Tue, 07 Feb 2006 12:42:18 -0800
Message-ID: <7vfymuvr2t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602071020120.3854@g5.osdl.org>
	<Pine.LNX.4.64.0602071024270.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 21:45:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6ZfM-0001du-2j
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 21:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWBGUmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 15:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWBGUmV
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 15:42:21 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47615 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750792AbWBGUmU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 15:42:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207203914.QTRT17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 15:39:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602071024270.3854@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 7 Feb 2006 10:26:41 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15712>

Linus Torvalds <torvalds@osdl.org> writes:

> Ahh. Very simple.
>
> The "--cc" implies "-p", but without the recursive part.

Thanks.
