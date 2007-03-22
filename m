From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Thu, 22 Mar 2007 00:15:28 -0700
Message-ID: <7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
	<20070322062805.GD6303@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Mar 22 08:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUHWU-0002CW-0w
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 08:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbXCVHPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 03:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbXCVHPc
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 03:15:32 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40843 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbXCVHP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 03:15:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322071528.QNJZ18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 03:15:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id djFU1W00p1kojtg0000000; Thu, 22 Mar 2007 03:15:29 -0400
In-Reply-To: <20070322062805.GD6303@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 22 Mar 2007 08:28:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42844>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

> BTW, is there some way to figure it out besides looking at the code
> or grepping git archives?

Like SubmittingPatches?
