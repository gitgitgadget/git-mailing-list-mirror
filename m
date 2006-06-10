From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.4.0
Date: Sat, 10 Jun 2006 16:42:57 -0700
Message-ID: <7virn8h91a.fsf@assigned-by-dhcp.cox.net>
References: <7vmzckhfsx.fsf@assigned-by-dhcp.cox.net>
	<4d8e3fd30606101537n2d099ee4g5e86956bdfc5cb5@mail.gmail.com>
	<4d8e3fd30606101547x46b94058u3bb48ba8d25dc48d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 01:43:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpD6d-00034e-LR
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 01:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWFJXm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 19:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWFJXm7
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 19:42:59 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7875 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161054AbWFJXm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 19:42:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610234258.YZDV24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Jun 2006 19:42:58 -0400
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
In-Reply-To: <4d8e3fd30606101547x46b94058u3bb48ba8d25dc48d@mail.gmail.com>
	(Paolo Ciarrocchi's message of "Sun, 11 Jun 2006 00:47:30 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21628>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> Ok, solved doing (as suggested on #git)
> /.git/remotes$ vi origin
> and removed:
> Pull: jc/bind:jc/bind
>
> What happened to that branch?

It was an experiment for "bind commit" which has been vetoed and
discarded now.  Sorry about the confusion.
