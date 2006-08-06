From: Paul Eggert <eggert@CS.UCLA.EDU>
Subject: Re: kompare won't parse git diffs
Date: Sat, 05 Aug 2006 23:14:33 -0400
Message-ID: <87fygao8rq.fsf@penguin.cs.ucla.edu>
References: <200608021107.43485.andyparkins@gmail.com>
	<Pine.LNX.4.64.0608021006150.4168@g5.osdl.org>
	<eaqpt2$ots$1@sea.gmane.org> <7vy7u7t0ap.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 05:14:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Z6C-0001Rr-NR
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 05:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWHFDOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 23:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWHFDOm
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 23:14:42 -0400
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:4523 "EHLO kiwi.cs.ucla.edu")
	by vger.kernel.org with ESMTP id S1751505AbWHFDOl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 23:14:41 -0400
Received: from penguin.cs.ucla.edu (Penguin.CS.UCLA.EDU [131.179.64.200])
	by kiwi.cs.ucla.edu (8.11.7p2+Sun/8.11.7/UCLACS-5.2) with ESMTP id k763EX922736;
	Sat, 5 Aug 2006 20:14:33 -0700 (PDT)
Received: from eggert by penguin.cs.ucla.edu with local (Exim 4.50)
	id 1G9Z61-0006J3-8e; Sat, 05 Aug 2006 20:14:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7u7t0ap.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 02 Aug 2006 12:17:18 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24956>

Junio C Hamano <junkio@cox.net> writes:

> I wonder what happened to the plan to update GNU diff/patch to
> also emit/understand the c-style quoted paths.  Paul?

It's still intended, but not yet implemented unfortunately.
