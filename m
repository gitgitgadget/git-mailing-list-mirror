From: Junio C Hamano <junkio@cox.net>
Subject: Re: make tests ignorable with "make -i"
Date: Tue, 08 Nov 2005 11:29:59 -0800
Message-ID: <7vmzkfey4o.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511080151v69bc4578we093eaa751ee4bac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 20:33:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZZAW-0002wN-NB
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 20:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbVKHTaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 14:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbVKHTaF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 14:30:05 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59282 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965275AbVKHTaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 14:30:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108192940.BXNK16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 14:29:40 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11350>

Alex Riesen <raa.lkml@gmail.com> writes:

> ...  (Or to ignore plainly
> uninteresting situations because of the testing being done on say...
> cygwin ;)

Could you tell us which ones break on Cygwin?
