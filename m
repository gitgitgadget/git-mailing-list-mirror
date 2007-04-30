From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Option --smtp-server clarified. The argument can be of two kinds
Date: Mon, 30 Apr 2007 16:51:14 -0700
Message-ID: <7vvefda0b1.fsf@assigned-by-dhcp.cox.net>
References: <3b2ixcl3.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue May 01 01:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifeK-0003vC-UV
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946119AbXD3XvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946158AbXD3XvS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:51:18 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34159 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946119AbXD3XvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:51:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430235117.DIDP1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 19:51:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tbrE1W00S1kojtg0000000; Mon, 30 Apr 2007 19:51:15 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45902>

Jari Aalto <jari.aalto@cante.net> writes:

> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  (1) eol whitespace removal
>
>  (2) The first 3 lines are actual changes. The rest is due to formatting
>  of the paragraph (fill).

This patch itself is small enough so it is not a big deal, but
please do not mix whitespace fix and other patches if the
changes are involved.  Also please do not re-linewrap asciidoc
sources when not needed.
