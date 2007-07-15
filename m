From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make every builtin-*.c file #include "builtin.h"
Date: Sat, 14 Jul 2007 23:12:11 -0700
Message-ID: <7v4pk6fb5w.fsf@assigned-by-dhcp.cox.net>
References: <20070714231445.GA21180@scanner.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Hagervall <hager@cs.umu.se>
X-From: git-owner@vger.kernel.org Sun Jul 15 08:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9xLJ-0006gL-H3
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 08:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbXGOGMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 02:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbXGOGMO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 02:12:14 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:44582 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbXGOGMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 02:12:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070715061212.OZXV1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Jul 2007 02:12:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PiCB1X00C1kojtg0000000; Sun, 15 Jul 2007 02:12:12 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52529>

Makes sense, thanks.
