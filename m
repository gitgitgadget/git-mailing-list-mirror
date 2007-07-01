From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: cache max revision in rev_db databases
Date: Sat, 30 Jun 2007 23:49:48 -0700
Message-ID: <7vwsxk7h4j.fsf@assigned-by-dhcp.cox.net>
References: <7vfy48940k.fsf@assigned-by-dhcp.cox.net>
	<20070701053114.GA1787@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 01 08:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4tFq-0008Fn-Kk
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 08:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXGAGtu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 02:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbXGAGtu
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 02:49:50 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:41530 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbXGAGtt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 02:49:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701064949.QXPM1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 02:49:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J6po1X0091kojtg0000000; Sun, 01 Jul 2007 02:49:49 -0400
In-Reply-To: <20070701053114.GA1787@muzzle> (Eric Wong's message of "Sat, 30
	Jun 2007 22:31:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51281>

Thanks.
