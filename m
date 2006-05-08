From: Junio C Hamano <junkio@cox.net>
Subject: Re: Command to list commits that point to a given tree.
Date: Mon, 08 May 2006 13:34:24 -0700
Message-ID: <7vvesgfe7j.fsf@assigned-by-dhcp.cox.net>
References: <20060508163437.GA17390@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 22:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdCR4-0005L5-Jy
	for gcvg-git@gmane.org; Mon, 08 May 2006 22:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWEHUe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 16:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWEHUe0
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 16:34:26 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51853 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750722AbWEHUe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 16:34:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508203425.HRQN25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 May 2006 16:34:25 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20060508163437.GA17390@hpsvcnb.fc.hp.com> (Carl Baldwin's
	message of "Mon, 8 May 2006 10:34:37 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19775>

Carl Baldwin <cnb@fc.hp.com> writes:

> ... In particular, I am
> looking for a command that will return a list of commits that point to a
> particular tree.
>
> Right now I plan to brute force it.

You might want to explain what problem you are trying to solve,
by knowing which commit contains a particular tree object.
There might be a solution to that unstated problem which does
not require the reverse lookup.
