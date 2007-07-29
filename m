From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Sun, 29 Jul 2007 15:15:11 -0700
Message-ID: <7vk5sin9g0.fsf@assigned-by-dhcp.cox.net>
References: <85lkcyvr4f.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 00:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFH30-0005AM-7f
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 00:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbXG2WPP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 18:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936593AbXG2WPO
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 18:15:14 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:45062 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936586AbXG2WPN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 18:15:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729221512.KZUW7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Jul 2007 18:15:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VaFB1X0071kojtg0000000; Sun, 29 Jul 2007 18:15:12 -0400
In-Reply-To: <85lkcyvr4f.fsf@lola.goethe.zz> (David Kastrup's message of "Sun,
	29 Jul 2007 23:26:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54140>

I thought we already rejected the "install symlink" in the
earlier round.  Am I mistaken, or are there any compelling new
reasons to revisit it?
