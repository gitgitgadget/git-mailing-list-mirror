From: Junio C Hamano <junkio@cox.net>
Subject: Re: Organizing (large) test data in git
Date: Tue, 27 Feb 2007 12:49:29 -0800
Message-ID: <7vhct7come.fsf@assigned-by-dhcp.cox.net>
References: <17892.28995.328911.23188@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272049560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17892.36336.249022.904854@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272113430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17892.37416.358405.211524@lisa.zopyra.com>
	<Pine.LNX.4.63.0702272119430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:49:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9GQ-00037w-4b
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbXB0Utb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbXB0Utb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:49:31 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46066 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbXB0Uta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:49:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227204929.TCSP233.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 15:49:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UkpW1W0011kojtg0000000; Tue, 27 Feb 2007 15:49:30 -0500
In-Reply-To: <Pine.LNX.4.63.0702272119430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 27 Feb 2007 21:22:31 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40802>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But if you do not care for history, instead just for being up-to-date, it 
> should help you.

I had a distinct impression that Bill was talking about a narrow
checkout, not a shallow clone, but it probably is just me.

> P.S.: And no, I don't remember if you need to say "--depth 2" or "--depth 
> 1" for that... Sorry

Depth 1 AFAICR meant "the tip plus one parent".
