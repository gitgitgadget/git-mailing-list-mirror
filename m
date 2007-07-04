From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pingback/Trackback for Git?
Date: Tue, 03 Jul 2007 22:10:40 -0700
Message-ID: <7vbqeslpnz.fsf@assigned-by-dhcp.cox.net>
References: <372f54da0707030512k79e2dc74m98bf0a690abffc4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Thomas Perl" <th.perl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 07:11:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5x92-0001Ir-9F
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 07:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbXGDFKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 01:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbXGDFKy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 01:10:54 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41246 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbXGDFKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 01:10:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704051041.IFRS17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 01:10:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KHAg1X0051kojtg0000000; Wed, 04 Jul 2007 01:10:41 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51568>

"Thomas Perl" <th.perl@gmail.com> writes:

> I've outlined some ideas here, feel free to suggest implementations or
> point out problems:
>
> http://tperl.blogspot.com/2007/07/pingbacktrackback-for-git.html

It was unclear to me who does what and when in the overall
picture you envision after reading that page.  You seem to
assume there is a prominent ping/trackback repository that
everybody who is interested looks at.  Who updates it?  When?
With what?  How does the namespace inside that repository
managed, if managed in any way?  Given a project name, how does
one learn which pick/grackback repository (and perhaps which
branch) to go to to learn the current status about it?
