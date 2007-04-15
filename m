From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Sun, 15 Apr 2007 19:21:24 -0400
Message-ID: <20070415232123.GA13515@fieldses.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org> <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com> <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org> <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com> <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org> <7v6484vxd5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org> <7vk5wkuf35.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704101701030.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:21:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdE2P-0000PM-Hu
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbXDOXVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754069AbXDOXVg
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:21:36 -0400
Received: from mail.fieldses.org ([66.93.2.214]:55152 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbXDOXVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:21:36 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdE28-00088u-33; Sun, 15 Apr 2007 19:21:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704101701030.28181@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44544>

On Tue, Apr 10, 2007 at 05:03:13PM -0400, Nicolas Pitre wrote:
> This is definitively good Documentation/howto/ material.

There's actually something similar already in "modifying a single
commit" in the "user manual":

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#id276844

But it uses a throw-away branch instead of the detached head, and uses
rebase --onto instead of rebasing and then --skip'ing.

--b.
