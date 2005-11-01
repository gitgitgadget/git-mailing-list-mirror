From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on GIT usage.
Date: Mon, 31 Oct 2005 16:23:56 -0800
Message-ID: <7v7jbtb4gz.fsf@assigned-by-dhcp.cox.net>
References: <4362C700.6020901@candelatech.com>
	<Pine.LNX.4.64.0510311749080.25300@iabervon.org>
	<Pine.LNX.4.64.0510311520190.27915@g5.osdl.org>
	<Pine.LNX.4.64.0510311821410.25300@iabervon.org>
	<Pine.LNX.4.64.0510311540300.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 01:24:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWjwc-0006eT-Jm
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 01:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVKAAYD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 19:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbVKAAYD
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 19:24:03 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12503 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964919AbVKAAYC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 19:24:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051101002312.FFOS11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 19:23:12 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510311540300.27915@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 31 Oct 2005 15:42:33 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10907>

Linus Torvalds <torvalds@osdl.org> writes:

> I _think_ you should be able to just do
>
> 	git pull <repodir> <branchname>
>
> where <repodir> can even be just "." for the very same repository.
>
> I've not tested it, but dammit, it should work. If it doesn't, it's a bug.

I know it works.  'git pull . somebranch' is the command I use
the second most often in the git suite (the first being
git-show-branch).
