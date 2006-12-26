From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Tue, 26 Dec 2006 15:54:45 -0800
Message-ID: <7vd566ciwq.fsf@assigned-by-dhcp.cox.net>
References: <7vac1fy5ae.fsf@assigned-by-dhcp.cox.net>
	<418215.90592.qm@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 27 00:54:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzM8A-0004zp-Mg
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 00:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbWLZXyr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 18:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbWLZXyr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 18:54:47 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39716 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbWLZXyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 18:54:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061226235445.TDQU97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 18:54:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3buy1W00u1kojtg0000000; Tue, 26 Dec 2006 18:54:59 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <418215.90592.qm@web31809.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Tue, 26 Dec 2006 12:25:37 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35436>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> I am not quite sure about that.  An old timer would work in a
>> newly cloned repository after all, and what this "newbie
>> protection" is breaking is not existing repositories but
>> expectation from existing users.
>
> Hmm, "newbie protection" doesn't sound good.  It sounds like
> "screw the old-timers and let's change well-established workflow".

As far as I am concerned, this is a topic already closed four
days ago with commit fb8696d9.

Are you way too behind, are you rubbing it in, or am I
hallucinating and fb8696d9 did not actually fix it?
