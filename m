From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] revision walker: introduce shortcut -g for --walk-reflogs
Date: Wed, 24 Jan 2007 15:09:10 -0800
Message-ID: <7vveiwdnu1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701241505050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 00:09:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9rFK-0006Mv-2t
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 00:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876AbXAXXJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 18:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbXAXXJN
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 18:09:13 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50699 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932876AbXAXXJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 18:09:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070124230911.WAFH7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 18:09:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FB9V1W00d1kojtg0000000; Wed, 24 Jan 2007 18:09:29 -0500
In-Reply-To: <Pine.LNX.4.63.0701241505050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 24 Jan 2007 15:05:16 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37689>

I think this makes sense (will do the same for the other one).
