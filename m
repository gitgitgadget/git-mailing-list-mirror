From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision walker --boundary: show boundaries again
Date: Tue, 06 Mar 2007 15:02:57 -0800
Message-ID: <7v8xeanffi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703061252110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:04:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOihR-0003hf-DR
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030654AbXCFXDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030658AbXCFXDF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:03:05 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:57217 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030655AbXCFXC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:02:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306230257.XQOP748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Mar 2007 18:02:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xb2x1W00R1kojtg0000000; Tue, 06 Mar 2007 18:02:57 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41609>

Thanks.

I noticed the breakage after those 4 series and have two fixups
near the tip of 'next', namely 8839ac94.  Does it not work for
you?

Btw, the version of gitweb running on git.kernel.org seems to be
broken. Clicking on 'next' label itself or 'shortlog' link next
to it would not show what's requested for 'next', but 'log' link
seems to work.
