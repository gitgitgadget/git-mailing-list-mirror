From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revert/cherry-pick: allow the last parameter to be -h
Date: Wed, 23 May 2007 00:04:13 -0700
Message-ID: <7vsl9o3tsi.fsf@assigned-by-dhcp.cox.net>
References: <20070522212945.GA8002@diku.dk>
	<20070522221156.GL30871@steel.home>
	<7vwsz07b10.fsf@assigned-by-dhcp.cox.net>
	<20070523053110.GA23971@diku.dk>
	<7v8xbg5bno.fsf@assigned-by-dhcp.cox.net>
	<20070523065750.GA25931@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed May 23 09:04:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqktP-0003ug-6P
	for gcvg-git@gmane.org; Wed, 23 May 2007 09:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbXEWHEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 03:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756924AbXEWHEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 03:04:16 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42514 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624AbXEWHEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 03:04:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523070415.CFGX13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 23 May 2007 03:04:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2X4D1X0041kojtg0000000; Wed, 23 May 2007 03:04:14 -0400
In-Reply-To: <20070523065750.GA25931@diku.dk> (Jonas Fonseca's message of
	"Wed, 23 May 2007 08:57:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48146>

Jonas Fonseca <fonseca@diku.dk> writes:

> But --help is handled elsewhere, you meant -h ...

Quite true.  I meant --usage.
