From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors pushing tags in "next"
Date: Thu, 22 Mar 2007 19:48:17 -0700
Message-ID: <7vr6rgsmj2.fsf@assigned-by-dhcp.cox.net>
References: <958071.66875.qm@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Fri Mar 23 03:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUZpU-00017Y-78
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 03:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbXCWCsT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 22:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753042AbXCWCsT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 22:48:19 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41414 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbXCWCsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 22:48:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323024816.XMOA1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Mar 2007 22:48:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id e2oH1W0031kojtg0000000; Thu, 22 Mar 2007 22:48:17 -0400
In-Reply-To: <958071.66875.qm@web31811.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Thu, 22 Mar 2007 19:03:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42898>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Is this of any concern?

Sorry, I cannot tell without a command line.

> ### Pushing version 'v2.6.21-rc4' to the masses
> fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594': unknown
> revision or path not in the working tree.
> Use '--' to separate paths from revisions
> fatal: ambiguous argument 'v2.6.21-rc3-329..bac6eefe96204d0ad67d144f2511a6fc487aa594': unknown
> revision or path not in the working tree.
> Use '--' to separate paths from revisions
> refs/tags/v2.6.21-rc4: 0000000000000000000000000000000000000000 ->
> bac6eefe96204d0ad67d144f2511a6fc487aa594
>
> Thanks,
>    Luben
>
> P.S.
> git --version
> git version 1.5.1.rc1.901.gb7f2
