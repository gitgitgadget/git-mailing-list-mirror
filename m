From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-feed-mail-list.sh
Date: Mon, 08 May 2006 17:57:13 -0700
Message-ID: <7vejz4c8wm.fsf@assigned-by-dhcp.cox.net>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	<7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	<1147131877.2694.37.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	<1147134522.2694.45.camel@shinybook.infradead.org>
	<7vu080c9uv.fsf@assigned-by-dhcp.cox.net>
	<4fb292fa0605081753r1d9e7cb6u3a9b513bcbf2404a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:57:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGXQ-0007BH-9k
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWEIA5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWEIA5Q
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:57:16 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17347 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751068AbWEIA5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 20:57:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509005714.LRVP17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 20:57:14 -0400
To: "Bertrand Jacquin" <beber.mailing@gmail.com>
In-Reply-To: <4fb292fa0605081753r1d9e7cb6u3a9b513bcbf2404a@mail.gmail.com>
	(Bertrand Jacquin's message of "Tue, 9 May 2006 02:53:24 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19796>

"Bertrand Jacquin" <beber.mailing@gmail.com> writes:

> What is --parents for ?

In the part you did not quote, David wanetd a way to grab the
parents of the commit in question, so I gave it to him.

> Is there a way to have a --pretty=fuller with date append to Author
> and Commiter name and email instead of have 1 lign after each ?

sed is your friend.
