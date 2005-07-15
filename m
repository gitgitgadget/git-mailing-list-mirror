From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [ANNOUNCE] Gct-0.1, a GUI enabled Git commit tool
Date: Fri, 15 Jul 2005 02:46:42 +0200
Message-ID: <914f22914f26.914f26914f22@liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 15 02:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtELt-0001hw-C6
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 02:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVGOAqs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 20:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVGOAqs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 20:46:48 -0400
Received: from elysium.unit.liu.se ([130.236.230.145]:3315 "EHLO
	elysium.unit.liu.se") by vger.kernel.org with ESMTP id S262983AbVGOAqq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 20:46:46 -0400
Received: by elysium.unit.liu.se (Postfix, from userid 102)
	id 0337F339AE; Fri, 15 Jul 2005 02:46:45 +0200 (MEST)
Received: from liu.se (avalon.unit.liu.se [130.236.230.138])
	by elysium.unit.liu.se (Postfix) with ESMTP id A2232339AE
	for <git@vger.kernel.org>; Fri, 15 Jul 2005 02:46:42 +0200 (MEST)
Received: from [81.228.155.80] by qom.unit.liu.se (mshttpd); Fri, 15 Jul
 2005 02:46:42 +0200
To: git@vger.kernel.org
X-Mailer: iPlanet Messenger Express 5.2 HotFix 2.05 (built Mar  3 2005)
Content-Language: sv
X-Accept-Language: sv
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.4-liu_20050621_1634 (2005-06-05) on 
	themis.unit.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=FROM_ENDS_IN_NUMS,
	LIU_FROM_MATCHES_LIUSTUDENT autolearn=disabled 
	version=3.0.4-liu_20050621_1634
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Gct v0.1 has been released and can be downloaded from
http://www.cyd.liu.se/~freku045/gct/gct-0.1.tar.gz

What follows is an excerpt from the README in the tarball:

Introduction
------------

Git Commit Tool or gct is a simple GUI enabled Git commit tool. It
allows the user to select which files should be committed, write
commit messages and perform the commit. It also has some support for
controlling the synchronisation between the Git cache and the working
directory.

Any comments, suggestions and/or bug reports regarding Gct are greatly
appreciated.

Requirements
------------

* Python, http://www.python.org
* Qt version 3.*, http://www.trolltech.com/products/qt/index.html
* PyQt, http://www.riverbankcomputing.co.uk/pyqt/
* Git a fairly recent snapshot,
 http://www.kernel.org/pub/software/scm/git/ and
 rsync://rsync.kernel.org/pub/scm/git/git.git

Gct has been developed with Python 2.3, Qt 3.3.4 and PyQt 2.13. Other
fairly recent versions may or may not work.


- Fredrik Kuivinen
