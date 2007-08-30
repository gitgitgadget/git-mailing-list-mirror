From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5701: "wc -l" may add whitespace
Date: Wed, 29 Aug 2007 23:13:25 -0700
Message-ID: <7vbqcpa6t6.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0708291752050.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 30 08:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQdHp-00010Z-6K
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 08:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbXH3GN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 02:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbXH3GN1
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 02:13:27 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42608 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbXH3GN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 02:13:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070830061325.KFWI16221.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 30 Aug 2007 02:13:25 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id i6DR1X00C1gtr5g0000000; Thu, 30 Aug 2007 02:13:25 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57002>

Isn't this already in as 70f64148bf7ca5136f2aa18c41b3b8f4bebfd138
(Fix t5701-clone-local for white space from wc)?
