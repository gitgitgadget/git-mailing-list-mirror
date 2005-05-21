From: Sam Ravnborg <sam@ravnborg.org>
Subject: cogito - how do I ???
Date: Sat, 21 May 2005 23:47:00 +0200
Message-ID: <20050521214700.GA18676@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat May 21 23:43:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZbks-0003ml-8R
	for gcvg-git@gmane.org; Sat, 21 May 2005 23:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVEUVon (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 17:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVEUVon
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 17:44:43 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:55845 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261633AbVEUVol
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 17:44:41 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id D473A5EE01D
	for <git@vger.kernel.org>; Sat, 21 May 2005 23:44:40 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id EDB6B6AC08F; Sat, 21 May 2005 23:47:00 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi all.

While trying to get up to speed on cogito/git I stumbled across
a few things that I at least did not find available in cogito.

1) Something similar to "bk changes -R". I use this to see what has
happened upstream - to see if I really want to merge stuff.

2) Export of individual patches. "bk export -tpatch -r1.2345"
I have nu public git repository yet so I have to feed changes as
plain patches. Browsing cg-* I did not find the command to do this.

I do try to avoid having to develop my little army of shell scripts,
and due to this I have avoided the git- commands for now.

Any help appreciated,
	Sam
