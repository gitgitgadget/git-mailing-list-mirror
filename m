From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] missing return
Date: Wed, 30 May 2007 10:24:31 -0700
Message-ID: <7vk5uq2pio.fsf@assigned-by-dhcp.cox.net>
References: <465D709E.7040402@freemail.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jerald Fitzjerald <jfj@freemail.gr>
X-From: git-owner@vger.kernel.org Wed May 30 19:24:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtRuj-0002CT-KZ
	for gcvg-git@gmane.org; Wed, 30 May 2007 19:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbXE3RYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 13:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757386AbXE3RYd
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 13:24:33 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:43689 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756684AbXE3RYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 13:24:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070530172431.RHPW13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 30 May 2007 13:24:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5VQX1X00X1kojtg0000000; Wed, 30 May 2007 13:24:32 -0400
In-Reply-To: <465D709E.7040402@freemail.gr> (Jerald Fitzjerald's message of
	"Wed, 30 May 2007 05:39:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48773>

Jerald Fitzjerald <jfj@freemail.gr> writes:

> OK for mainline?

Sure, with a signoff please.

I realize that I've seen this pointed out by somebody already.
Thanks for reminder.
