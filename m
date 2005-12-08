From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/17] Document the [<head>...] and -- arguments to git-prune.
Date: Thu, 08 Dec 2005 15:49:42 -0800
Message-ID: <7v4q5jb149.fsf@assigned-by-dhcp.cox.net>
References: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
	<1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 00:50:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVWG-0001bT-0G
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbVLHXtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbVLHXtp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:49:45 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:37087 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932752AbVLHXto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:49:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208234827.RXBU17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 18:48:27 -0500
To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13403>

Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org> writes:

> The documentation for git-prune was lacking descriptions of the head
> arguments and the -- option.
>
> +<head>...::
> +        The heads to look for unreachable objects in.  This is
> +        relative to $GIT_DIR (e.g., "HEAD", "refs/heads/master").
> +        When unspecified, all heads are updated to match the
> +        remote repository.

? updated to match???

All others look very good.  Thanks for taking time to do this;
very much appreciated.
