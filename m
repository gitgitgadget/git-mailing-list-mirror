From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-remote to update existing remotes by fetching from them
Date: Sun, 18 Feb 2007 21:18:09 -0800
Message-ID: <7virdybu9a.fsf@assigned-by-dhcp.cox.net>
References: <E1HIzh2-0001Ph-T2@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 19 06:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ0ul-0006Ix-Gd
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 06:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbXBSFSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 00:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbXBSFSM
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 00:18:12 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41591 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbXBSFSL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 00:18:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070219051811.DGIR1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Feb 2007 00:18:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RHJ91W00w1kojtg0000000; Mon, 19 Feb 2007 00:18:11 -0500
In-Reply-To: <E1HIzh2-0001Ph-T2@candygram.thunk.org> (Theodore Ts'o's message
	of "Sun, 18 Feb 2007 23:00:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40097>

"Theodore Ts'o" <tytso@mit.edu> writes:

> This allows users to use the command "git remote update" to update all
> remotes that are being tracked in the repository.

Sounds like a good idea.  Thanks.
