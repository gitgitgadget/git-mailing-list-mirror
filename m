From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [ANNOUNCE] (H)gct 0.2
Date: Sun, 21 Aug 2005 16:58:51 +0200
Message-ID: <20050821145851.GA24034@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 21 16:59:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6rIC-0006RV-2Q
	for gcvg-git@gmane.org; Sun, 21 Aug 2005 16:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVHUO7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 10:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVHUO7F
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 10:59:05 -0400
Received: from [85.8.31.11] ([85.8.31.11]:4772 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751036AbVHUO7B (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2005 10:59:01 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP id 8977C40FF
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 17:02:33 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1E6rHf-0006G6-00
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 16:58:51 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Version 0.2 of (H)gct, a GUI enabled commit tool, has been released
and can be downloaded from
http://www.cyd.liu.se/~freku045/gct/gct-0.2.tar.gz

There is also a Git repository for (H)gct at
http://www.cyd.liu.se/users/~freku045/gct/gct.git/ (and a gitweb for
this repository is available at
http://www.cyd.liu.se/users/~freku045/gct/gitweb.cgi)

Some screen shots can be found on the homepage at
http://www.cyd.liu.se/~freku045/gct


The major changes compared to v0.1 are:

* User interface enhancements: 
  - automatically add signoff to commit message
  - jump directly into an editor to modify files
  - ignore file (hg only)
  - preferences panel
  - revert changes
  - (un)select all changes
* Support for Mercurial (hg) repositories via the "hgct" command
* Generic SCM interface allows easy porting to other SCM systems
* Assorted small bugfixes and enhancements

Lots of thanks to Mark Williamson for the Hg support, patches and
ideas.

- Fredrik
