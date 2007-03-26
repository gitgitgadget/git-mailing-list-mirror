From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Mon, 26 Mar 2007 11:45:26 -0700
Message-ID: <7vlkhjx2rd.fsf@assigned-by-dhcp.cox.net>
References: <20070326073502.GD44578@codelabs.ru>
	<7vwt14xvaw.fsf@assigned-by-dhcp.cox.net>
	<20070326083617.GG13247@spearce.org>
	<7v8xdkxukt.fsf@assigned-by-dhcp.cox.net>
	<20070326100857.GW14837@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:45:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVuCD-00080g-2p
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 20:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbXCZSpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 14:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753686AbXCZSpa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 14:45:30 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:55965 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbXCZSp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 14:45:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326184528.LUIK1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 14:45:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fWlT1W00A1kojtg0000000; Mon, 26 Mar 2007 14:45:27 -0400
In-Reply-To: <20070326100857.GW14837@codelabs.ru> (Eygene Ryabinkin's message
	of "Mon, 26 Mar 2007 14:08:57 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43174>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

>> Two tips.
>> 
>>  (1) Learn to use left/right arrow keys under "less -S" if you
>>      have occasional lines that are too long.
>
> I do not like the left/right keys: it is wery hard to get the
> right typing speed ...

Heh, who types 120-word a minute while perusing the source with
"less"?

I do not like to move my hand from the home position on the
keyboard either, so I never touch arrow keys while I am typing
to produce, but I never thought of bothering to reconfigure less
keybindings for the reason you stated, as I do not have infinite
amount of time.
