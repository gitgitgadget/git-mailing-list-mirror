From: Sebastian Kuzminsky <seb@highlab.com>
Subject: manpage name conflict
Date: Thu, 19 May 2005 09:29:52 -0600
Message-ID: <E1DYmy8-0003YB-JW@highlab.com>
X-From: git-owner@vger.kernel.org Thu May 19 17:33:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYmwb-0005Y3-HO
	for gcvg-git@gmane.org; Thu, 19 May 2005 17:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVESP25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 11:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVESP25
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 11:28:57 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:50900 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262526AbVESP2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 11:28:47 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005051915284601400ntu0ie>; Thu, 19 May 2005 15:28:46 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DYmy8-0003YB-JW
	for git@vger.kernel.org; Thu, 19 May 2005 09:29:52 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi folks, I maintain a Debian package for Cogito (it just went into "Sid"
aka "unstable"), and I just got a bug report from a user that I'd like
your input on.


The problem is that Cogito wants to install a git(1) manpage, and so does
the GNU Interactive Tools.  The GNU Interactive Tools actually have a
program called "git", so it seems only fair that they get to call their
manpage by the same name.  The GIT-as-in-Cogito git(1) manpage gives
an overview of the GIT-as-in-Cogito core, so maybe we could install it
as git-core(1)?


What do you think?


-- 
Sebastian Kuzminsky
"Marie will know I'm headed south, so's to meet me by and by"
-Townes Van Zandt
