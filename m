From: Junio C Hamano <junkio@cox.net>
Subject: Re: how to make a git-format patch
Date: Wed, 12 Apr 2006 22:53:13 -0700
Message-ID: <7vveteyqba.fsf@assigned-by-dhcp.cox.net>
References: <6d6a94c50604120328ufa09f0do76c04472206ae15f@mail.gmail.com>
	<m3sloiriu7.fsf@localhost.localdomain>
	<6d6a94c50604122236i47f3c2e9s7656118eda95a2cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 07:53:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTulo-00030m-9e
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 07:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWDMFxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 01:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWDMFxU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 01:53:20 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:2985 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932397AbWDMFxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 01:53:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413055315.NLD24255.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 01:53:15 -0400
To: Aubrey <aubreylee@gmail.com>
In-Reply-To: <6d6a94c50604122236i47f3c2e9s7656118eda95a2cd@mail.gmail.com>
	(aubreylee@gmail.com's message of "Thu, 13 Apr 2006 13:36:05 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18650>

Aubrey <aubreylee@gmail.com> writes:

> git whatchanged -p didn't include the signoff and howmany lines
> changed which git-format-patch seems not include commit comments.
>
> Is there one command to merge the two kind of message?

I think you already guessed it, judging from the Subject: line,
but the command is called "git-format-patch", and was around for
a long time.
