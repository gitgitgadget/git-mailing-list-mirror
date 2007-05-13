From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Fix assorted white space damage
Date: Sun, 13 May 2007 11:57:33 -0700
Message-ID: <7vk5vcsg9u.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705120409v629425aesc910927c26871323@mail.gmail.com>
	<7vzm49ts2f.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705131230230.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 13 20:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnJGF-0003Zq-4B
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbXEMS5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757489AbXEMS5e
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:57:34 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34437 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbXEMS5e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 14:57:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513185734.TYTI13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 14:57:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yixZ1W0041kojtg0000000; Sun, 13 May 2007 14:57:33 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47168>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> AFAICT the documentation has trailing whitespace also, to indicate that 
> the paragraph does not end here. Correct me if I'm wrong, and these 
> trailing whitespaces are not necessary.

Thanks for the tip --- I did not know about deliberate trailing
whitespaces there.

It should be easy to verify by comparing the build products
before and after trailing whitespace removal, so I will try to
remember doing that.
