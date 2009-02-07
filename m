From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [FEATURE REQUEST] clear the screen
Date: Sat, 7 Feb 2009 15:03:02 +0100
Message-ID: <20090207140302.GB555@ultras>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 15:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVnpC-0001YR-7k
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 15:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbZBGOE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 09:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZBGOE6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 09:04:58 -0500
Received: from out2.laposte.net ([193.251.214.119]:30494 "EHLO
	out1.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbZBGOE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 09:04:57 -0500
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8202.laposte.net (SMTP Server) with ESMTP id CBEFF700008A
	for <git@vger.kernel.org>; Sat,  7 Feb 2009 15:04:54 +0100 (CET)
Received: from ? (88-122-115-145.rev.libertysurf.net [88.122.115.145])
	by mwinf8202.laposte.net (SMTP Server) with ESMTP id 93D507000088
	for <git@vger.kernel.org>; Sat,  7 Feb 2009 15:04:54 +0100 (CET)
X-ME-UUID: 20090207140454605.93D507000088@mwinf8202.laposte.net
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-me-spamlevel: not-spam
X-me-spamrating: 40.000000
X-me-spamcause: OK, (0)(0000)gggruggvucftvghtrhhoucdtuddrvdektddrkeefucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108854>


Hello,

'git add -i' is a very useful tool. I would like to be able to clear the
screen everywhere in it (regardless what the prompt is).
In shells like bash or zsh we have the clear command and the Ctrl+l
bind key.

Most of the time I use to use the bind key, but having an entry such as :
9: clear screen
would be useful (for me, at least).

Could it be possible to add both in git ?

-- 
Nicolas Sebrecht
