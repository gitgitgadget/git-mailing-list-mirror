From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] Remove whitespace breakage from *.c files
Date: Sun, 20 May 2007 14:36:13 -0700
Message-ID: <7vfy5rjhyq.fsf@assigned-by-dhcp.cox.net>
References: <4650222D.4070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 23:36:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpt4h-0007Oc-IG
	for gcvg-git@gmane.org; Sun, 20 May 2007 23:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbXETVgP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 17:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbXETVgP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 17:36:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58939 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548AbXETVgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 17:36:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520213615.FXMI15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 17:36:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1ZcD1X00X1kojtg0000000; Sun, 20 May 2007 17:36:14 -0400
In-Reply-To: <4650222D.4070707@gmail.com> (Marco Costalba's message of "Sun,
	20 May 2007 12:25:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47926>

Your MUA seem to have munged all your patches in this series;
and the breakage seems also to be in the "let apply eat the new
trailing blank lines" patch.
