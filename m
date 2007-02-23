From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 20:39:06 -0800
Message-ID: <7vps81bi8l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xeqllxk.fsf@assigned-by-dhcp.cox.net>
	<45DE5259.6090502@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 05:39:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKSDF-0007lG-4j
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 05:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbXBWEjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 23:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbXBWEjI
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 23:39:08 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43351 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbXBWEjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 23:39:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223043907.SVZV233.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 23:39:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ssf61W0091kojtg0000000; Thu, 22 Feb 2007 23:39:06 -0500
In-Reply-To: <45DE5259.6090502@verizon.net> (Mark Levedahl's message of "Thu,
	22 Feb 2007 21:32:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40413>

Mark Levedahl <mdl123@verizon.net> writes:

> I found the actual commit summary message (i.e., git-rev-list
> --pretty=one --max-count=1 sha1) the most useful of the various
> summaries available.

I would agree that would be the case, and Johannes's follow-up
seems to do that.
