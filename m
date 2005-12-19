From: Junio C Hamano <junkio@cox.net>
Subject: Re: using-topic-branches.txt
Date: Sun, 18 Dec 2005 21:33:17 -0800
Message-ID: <7v64plmz1e.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056F93AC@hdsmsx401.amr.corp.intel.com>
	<43A63C9B.7080306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 06:36:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoDeF-0000bM-SR
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 06:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVLSFdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 00:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVLSFdW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 00:33:22 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:22190 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030272AbVLSFdV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 00:33:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051219053237.ZHHR15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Dec 2005 00:32:37 -0500
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <43A63C9B.7080306@pobox.com> (Jeff Garzik's message of "Sun, 18
	Dec 2005 23:52:43 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13813>

Jeff Garzik <jgarzik@pobox.com> writes:

> master.kernel.org is non-public, so it shouldn't be mentioned in 
> documentation...

I'm willing to be persuaded otherwise, but the reason I changed
this part was twofold:

 - The documentation is meant to be an example for subsystem
   maintainers, who are "non-public" people anyway.

 - Linus publicly stated number of times that he fulfils the
   pull requests to him by pulling from master --- this avoids
   mirroring lag.  Not slowing down subsystem maintainers
   waiting for mirroring lag would equally be a good idea, I
   thought.
