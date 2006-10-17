From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] nice ftplugin for vim, that shows the commited diff in a split'ed buffer.
Date: Tue, 17 Oct 2006 15:04:39 -0700
Message-ID: <7vmz7uiop4.fsf@assigned-by-dhcp.cox.net>
References: <11610450702261-git-send-email-madcoder@debian.org>
	<200610171238.04372.madcoder@debian.org>
	<802d21790610170359v3f17438dn8009ae9a55b2405c@mail.gmail.com>
	<200610171304.39131.madcoder@debian.org>
	<46d6db660610171448h53de5e40wf55f19d6458127ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 00:04:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZx3D-0006F0-P8
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 00:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWJQWEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 18:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWJQWEl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 18:04:41 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56781 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbWJQWEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 18:04:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061017220440.WKMR18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Tue, 17 Oct 2006 18:04:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ba4S1V00H1kojtg0000000
	Tue, 17 Oct 2006 18:04:27 -0400
To: "Christian MICHON" <christian.michon@gmail.com>
In-Reply-To: <46d6db660610171448h53de5e40wf55f19d6458127ef@mail.gmail.com>
	(Christian MICHON's message of "Tue, 17 Oct 2006 23:48:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29124>

"Christian MICHON" <christian.michon@gmail.com> writes:

> On 10/17/06, Pierre Habouzit <madcoder@debian.org> wrote:
>> and that time, I'll send that to the git contrib/vim maintainer so that
>> I won't bother the list too much :)
>>
>
> so there is a contrib/vim maintainer ? Sorry I'm new on git list
> (though Pierre gave me some hints already with git/vim).

If you have git sources, check contrib/README please.

What I asked Pierre was to CC the patch to Jeff King who did
contrib/vim -- it was "send it to him too", and not "do not send
it to me".  I do not actively use vim myself so I am a wrong
person to judge patches to that part of the source tree.

Apparently Pierre seems to have thought that I thought patches
to the contrib/ part is "bothering the list", but that was not
my intention.  I believe showing your patches for review by
wider audiences is a good thing.
