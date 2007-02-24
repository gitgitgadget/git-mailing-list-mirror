From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch: Split fetch and merge logic
Date: Sat, 24 Feb 2007 02:23:15 -0800
Message-ID: <7v8xenzwfg.fsf@assigned-by-dhcp.cox.net>
References: <87ps7zj35b.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 24 11:23:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKu3t-0006M6-Li
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 11:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933479AbXBXKXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 24 Feb 2007 05:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933482AbXBXKXS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 05:23:18 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60542 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933479AbXBXKXR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Feb 2007 05:23:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070224102317.XTWG6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Feb 2007 05:23:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TNPG1W0061kojtg0000000; Sat, 24 Feb 2007 05:23:16 -0500
In-Reply-To: <87ps7zj35b.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Sat, 24
	Feb 2007 10:50:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40512>

Santi B=C3=A9jar <sbejar@gmail.com> writes:

>   I've addressed all the comments, now prepared to even more comments=
 :)
>
>   Junio, from your "What's cooking in git.git (topics)" I undestand t=
hat
>   the jc/fetch topic is not going to be in next soon (even for the fi=
rst
>   commit?). Anyway, the simple question is: Which branch (or commit) =
you
>   want me to base this patch?

=46or now this is fine.

I might have to postpone rebasing jc/fetch on top of this one
depending on my workload, but I'd want this clean-up first.

Thanks.
