From: Junio C Hamano <junkio@cox.net>
Subject: Re: This seems somewhat less that ideal
Date: Mon, 30 Apr 2007 21:29:59 -0700
Message-ID: <7vmz0p88u0.fsf@assigned-by-dhcp.cox.net>
References: <4634F508.5020702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Tue May 01 06:30:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hik09-0000PG-6K
	for gcvg-git@gmane.org; Tue, 01 May 2007 06:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031579AbXEAEaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 00:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbXEAEaF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 00:30:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51804 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030524AbXEAEaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 00:30:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501043000.XVGV1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 00:30:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tgVz1W0071kojtg0000000; Tue, 01 May 2007 00:29:59 -0400
In-Reply-To: <4634F508.5020702@gmail.com> (A. Large Angry's message of "Sun,
	29 Apr 2007 15:42:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45909>

A Large Angry SCM <gitzilla@gmail.com> writes:

> remote: Generating pack...
> remote: Done counting 46473 objects.
> remote: Deltifying 46473 objects.
> remote:  100% (46473/46473) done
> Indexing 46473 objects...
> remote: Total 46473 (delta 32624), reused 46043 (delta 32299)
>  100% (46473/46473) done
> Resolving 32624 deltas...
>  100% (32624/32624) done

Indeed it seems somewhat less than ideal.  Funny thing is that
it does not reproduce.
