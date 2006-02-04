From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two ideas for improving git's user interface
Date: Sat, 04 Feb 2006 00:25:34 -0800
Message-ID: <7virrv4jk1.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0602011656130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602011732560.21884@g5.osdl.org>
	<200602040803.45617.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 09:25:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Ijj-0000s8-IJ
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 09:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946350AbWBDIZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 03:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946354AbWBDIZg
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 03:25:36 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:14213 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1946350AbWBDIZg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 03:25:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204082305.CODV26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 03:23:05 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200602040803.45617.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Sat, 4 Feb 2006 08:03:45 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15578>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> Wow - light comes on.

That's good.

> -this tutorial the first time, I'd suggest to skip to "Publishing
> -your work" section and come back here later.
> +this tutorial the first time, I'd suggest to skip to "Resolving Merge
> +Problems" section and come back here later.

The changes before this look very good to me, but these two
lines do not make any sense. If you are going to talk about
"Resolving Merge Problems", you _need_ to know about index, so
you cannot skip the material.

I think having a section on manual merge resolution between the
Index File section and Publishing section makes sense.  What
kind of merges did you have trouble figuring out when you were
still git novice?  That would be a good starting point.
