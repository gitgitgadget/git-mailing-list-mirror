From: Carlos Martin Nieto <cmn@elego.de>
Subject: Re: bare vs non-bare <1.7 then >=1.7 ?
Date: Thu, 08 Nov 2012 14:26:40 +0100
Message-ID: <87zk2sz0mn.fsf@flaca.cmartin.tk>
References: <509B8552.4080303@rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Issues <git@vger.kernel.org>
To: Mihamina Rakotomandimby <mihamina@rktmb.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWSIT-00036Z-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 14:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab2KHNhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 08:37:15 -0500
Received: from hessy.cmartin.tk ([78.47.67.53]:52657 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751118Ab2KHNhO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 08:37:14 -0500
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2012 08:37:14 EST
Received: from cmartin.tk (z39c5.pia.fu-berlin.de [87.77.57.197])
	by hessy.dwim.me (Postfix) with ESMTPA id 13FD481639;
	Thu,  8 Nov 2012 14:26:41 +0100 (CET)
Received: (nullmailer pid 16358 invoked by uid 1000);
	Thu, 08 Nov 2012 13:26:40 -0000
In-Reply-To: <509B8552.4080303@rktmb.org> (Mihamina Rakotomandimby's message
	of "Thu, 08 Nov 2012 13:11:30 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209157>

Mihamina Rakotomandimby <mihamina@rktmb.org> writes:

> Hi all,
>
> We're on the way to have our first project using Git.
> We're currently mostly using Hg (90%) & SVN (10%).
>
> When experimenting in order to train some colleagues, I saw that If I
> clone a repository, I couldn't push to it because it was a non-bare
> one.
> Searchin for some explanations, I found this ressource:
> http://www.bitflop.com/document/111
>
> It's told to be reliable information for Git < v1.7.
>
> What would be different for Git > 1.7 so that I could be up to date
> with the facts?

Bare vs. non-bare hasn't changed. The reasoning behind the two types
hasn't changed and is pretty fundamental. There is no reason for it to
change.

   cmn
