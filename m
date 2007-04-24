From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Create a sysconfdir variable, and use it for ETC_GITCONFIG
Date: Tue, 24 Apr 2007 01:12:09 -0700
Message-ID: <7vwt028a3q.fsf@assigned-by-dhcp.cox.net>
References: <462D673A.1010805@freedesktop.org>
	<7vhcr6bdmk.fsf@assigned-by-dhcp.cox.net>
	<462D9938.8020206@freedesktop.org>
	<7vlkgi9utk.fsf@assigned-by-dhcp.cox.net>
	<462DB07C.5060500@freedesktop.org> <462DB707.4000008@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 10:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgG8H-0000Nw-4T
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 10:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbXDXIMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 04:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbXDXIMM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 04:12:12 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41983 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbXDXIMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 04:12:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424081209.USSI1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 04:12:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qwC91W0031kojtg0000000; Tue, 24 Apr 2007 04:12:09 -0400
In-Reply-To: <462DB707.4000008@freedesktop.org> (Josh Triplett's message of
	"Tue, 24 Apr 2007 00:51:35 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45426>

I like this much better.  Let's have this in 'maint' then.
