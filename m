From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RPMs for latest release
Date: Fri, 03 Aug 2007 13:37:07 -0700
Message-ID: <7vejikmk24.fsf@assigned-by-dhcp.cox.net>
References: <46B38125.9060805@centurytel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: rdavid274 <rdavid274@centurytel.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:37:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH3tY-0005X0-LC
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 22:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761353AbXHCUhK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760966AbXHCUhK
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 16:37:10 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:58055 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758736AbXHCUhI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 16:37:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803203708.MDDK14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 3 Aug 2007 16:37:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XYd71X00Q1kojtg0000000; Fri, 03 Aug 2007 16:37:08 -0400
In-Reply-To: <46B38125.9060805@centurytel.net> (rdavid274@centurytel.net's
	message of "Fri, 03 Aug 2007 11:25:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54755>

rdavid274 <rdavid274@centurytel.net> writes:

> Every rpm that I have downloaded depends on at 1 other rpm to have
> been already installed.
>
> So, how does a newbie deal with this issue?

A newbie will probably learn how to use rpm to deal with this
issue, I would presume.

Sorry, I do not run rpm based distro myself, but I would imagine
"rpm -i" (if -i is the "install" subcommand, I dunno) would take
more than one package name on the command line to be told to
install all of them at once?
