From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ignore submodule commits when fetching over dumb protocols
Date: Tue, 26 Jun 2007 17:41:45 -0700
Message-ID: <7vzm2mw7na.fsf@assigned-by-dhcp.pobox.com>
References: <20070626211940.GA27221@liacs.nl>
	<alpine.LFD.0.98.0706261434540.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Verdoolaege <skimo@liacs.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 02:42:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Lbi-0005Dc-La
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 02:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbXF0Alt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 20:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbXF0Als
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 20:41:48 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50642 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbXF0Alq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 20:41:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627004146.ICLR17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 20:41:46 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GQhl1X00D1kojtg0000000; Tue, 26 Jun 2007 20:41:46 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50991>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> This should probably be put in the maintenance branch, since I think we've 
> tried to make sure that the current 1.5.x series plumbing can handle 
> superproject data even if it doesn't then have the porcelain to make it 
> all easy..

Thanks, both.
