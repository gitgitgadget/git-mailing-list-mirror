From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] gitweb: Some improvements
Date: Mon, 04 Sep 2006 16:22:49 -0700
Message-ID: <7v8xkzkyie.fsf@assigned-by-dhcp.cox.net>
References: <200609041810.09838.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 01:22:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNlt-00047Y-Pt
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 01:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWIDXW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 19:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWIDXW0
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 19:22:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:26097 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965000AbWIDXWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 19:22:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904232225.DLNY6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Mon, 4 Sep 2006 19:22:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JPNJ1V0101kojtg0000000
	Mon, 04 Sep 2006 19:22:19 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609041810.09838.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 4 Sep 2006 18:10:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26451>

Jakub Narebski <jnareb@gmail.com> writes:

> This is small series of patches, applicable both to 'master' and 'next',
> which adds simple improvements, or in the case of last patch
> fix bug/typo.
>
> First two patches were sent earlier, I don't know if they were dropped
> or forgotten. 

I think you were just expecting too quick turnaround ;-).

If I recall correctly it used to be that we could not use png
for favicon but it seems that things have improved.

It is a while since I tried gitweb on my machine the last time
but was it always this slow I wonder...  We probably would need
a good benchmark and automated test before going too much
further.
