From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sat, 27 Jan 2007 23:44:34 -0800
Message-ID: <7vk5z7h9y5.fsf@assigned-by-dhcp.cox.net>
References: <20070127062826.GE14205@fieldses.org>
	<20070128002246.GA10179@moooo.ath.cx>
	<Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
	<20070128013452.GA11244@moooo.ath.cx>
	<Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
	<20070128024009.GB6545@socrates.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Sun Jan 28 08:44:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HB4iN-0001Uu-6I
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 08:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbXA1Hog (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 02:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbXA1Hog
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 02:44:36 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36962 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422AbXA1Hog (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 02:44:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128074435.FBX29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 02:44:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GXjc1W00S1kojtg0000000; Sun, 28 Jan 2007 02:43:37 -0500
cc: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <20070128024009.GB6545@socrates.priv> (Tom Prince's message of
	"Sat, 27 Jan 2007 18:40:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38022>

Please, do not break people's scripts that still use
repo-config.
