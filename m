From: Junio C Hamano <junkio@cox.net>
Subject: Re: using the same repo with different OS
Date: Sun, 25 Feb 2007 10:35:07 -0800
Message-ID: <7vy7mmrspw.fsf@assigned-by-dhcp.cox.net>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
	<Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702251929170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Spinucci <virgo977virgo@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 25 19:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLODJ-0006NF-Hn
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 19:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbXBYSfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 13:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbXBYSfJ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 13:35:09 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48234 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965061AbXBYSfI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 13:35:08 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225183507.OMMW2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 13:35:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tub61W00L1kojtg0000000; Sun, 25 Feb 2007 13:35:07 -0500
In-Reply-To: <Pine.LNX.4.63.0702251929170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 25 Feb 2007 19:30:19 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40566>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, in the case of a _bare_ repo, which is meant purely to transport 
> (possibly huge) changes from A to B, a USB stick can be used _without_ 
> problems. I do that myself quite often.

I think we are in agreement, but read the thread again.  You
brought up the index and my response is only about the
portability of the index.  Of course, the index does not matter
in a bare repository ;-)
