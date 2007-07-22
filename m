From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/gitignore.txt: Fix the seriously misleading priority explanation
Date: Sat, 21 Jul 2007 23:04:15 -0700
Message-ID: <7v4pjxt1nk.fsf@assigned-by-dhcp.cox.net>
References: <85wswtp8va.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 08:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICUYS-0006Z2-3D
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 08:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbXGVGER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 02:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXGVGER
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 02:04:17 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:54288 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbXGVGER (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 02:04:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070722060416.GTOQ1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 22 Jul 2007 02:04:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SW4F1X00J1kojtg0000000; Sun, 22 Jul 2007 02:04:16 -0400
In-Reply-To: <85wswtp8va.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	22 Jul 2007 01:53:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53221>

Your rewrite makes "patterns found in deeper file overrides the
ones in shallower ones" rule much much easier to read.  Thanks.
