From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Thu, 26 Jul 2007 11:56:16 -0700
Message-ID: <7vzm1j6lkf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
	<7vmyxj8wza.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707261459570.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 20:56:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE8Vi-0003NX-Bv
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 20:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935986AbXGZS40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 14:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934964AbXGZS4Z
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 14:56:25 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46002 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935952AbXGZS4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 14:56:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070726185624.OZMP1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 26 Jul 2007 14:56:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UJwM1X00V1kojtg0000000; Thu, 26 Jul 2007 14:56:23 -0400
In-Reply-To: <Pine.LNX.4.64.0707261459570.14781@racer.site> (Johannes
	Schindelin's message of "Thu, 26 Jul 2007 15:01:21 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53858>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...  Am I the only one who finds the new version much easier to read, 
> much like the pre-work-tree version?

Oh there is (modulo bugs to be worked on further) no question
about that.  The changes to environment.c alone would convince
anybody, I would say.  ;-).
