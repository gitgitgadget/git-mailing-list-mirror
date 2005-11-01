From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [ANNOUNCE] (H)gct 0.3
Date: Tue, 1 Nov 2005 20:37:25 +0100
Message-ID: <20051101193724.GC5711@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 01 20:38:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX1ws-0004UC-8y
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 20:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVKAThb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 14:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVKAThb
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 14:37:31 -0500
Received: from [85.8.31.11] ([85.8.31.11]:12672 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751203AbVKAThb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 14:37:31 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP id 1E5CF4103
	for <git@vger.kernel.org>; Tue,  1 Nov 2005 20:45:23 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EX1wj-0004KU-00
	for <git@vger.kernel.org>; Tue, 01 Nov 2005 20:37:25 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10949>

Hi,

Version 0.3 of (H)gct, a GUI enabled commit tool for Git and
Mercurial, has been released and can be downloaded from
http://www.cyd.liu.se/~freku045/gct/ct-0.3.tar.gz

Thanks to Vincent Danjean there are Debian packages available at
http://dept-info.labri.fr/~danjean/deb.html#commit-tool

Screen shots and a Git repository with a gitweb interface are
available at the project homepage, http://www.cyd.liu.se/~freku045/gct


The major changes compared to v0.2 are:

* File filter, show only file names which contain a specified string.
* Make ignoring files actually work.
* A new option, --one-shot, which makes (h)gct exit after the first
  commit.
* Support for new versions of git.
* An Hg extension which makes hgct better integrated with Hg. See
  README.HG for details.


- Fredrik
