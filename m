From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] user-manual: Use "git config --global" instead of editing ~/.gitconfig
Date: Thu, 10 May 2007 15:04:52 -0700
Message-ID: <7v7irgibcr.fsf@assigned-by-dhcp.cox.net>
References: <200705102353.31821.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 11 00:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmGlF-0004rX-1o
	for gcvg-git@gmane.org; Fri, 11 May 2007 00:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbXEJWFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 18:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759332AbXEJWFP
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 18:05:15 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33692 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656AbXEJWFO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 18:05:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510220459.DZA13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 18:05:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xa4s1W00u1kojtg0000000; Thu, 10 May 2007 18:04:53 -0400
In-Reply-To: <200705102353.31821.johan@herland.net> (Johan Herland's message
	of "Thu, 10 May 2007 23:53:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46907>

I think this was rejected before, and the reason was that the
point of this section is to make users aware that what novices
might think is internal is actually represented in a very simple
to understand and simple to change format, and reassure people
that making small mistakes can be fixed with an editor.

And I think that reasoning still stands.
