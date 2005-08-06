From: Sam Ravnborg <sam@ravnborg.org>
Subject: cogito - how to drop a commit
Date: Sun, 7 Aug 2005 00:34:36 +0200
Message-ID: <20050806223436.GA6495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 07 00:33:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1XES-0006pz-8Y
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 00:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVHFWdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 18:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVHFWdO
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 18:33:14 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:54378 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261250AbVHFWdN
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 18:33:13 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepc.post.tele.dk (Postfix) with ESMTP id A01EA262828
	for <git@vger.kernel.org>; Sun,  7 Aug 2005 00:33:12 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id F13896AC01D; Sun,  7 Aug 2005 00:34:36 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I accidently commited too many files to my tree today, and now I want to
drop the commit so I have logically separate commits.

What is the right way to do this - in cogito hopefully.

I do not mind to execute a few git commands, but for my daily usage I
expect cogito to hanle everything and dropping a commit has proved
useful for me from time to time, so I expect it be be implemented in the
porcelain somehow.

I have read the help for cg-seek - but it di not convince me to be what
I seeked.

	Sam
