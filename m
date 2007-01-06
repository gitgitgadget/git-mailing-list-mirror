From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: [ANNOUNCE] Guilt 0.16
Date: Sat, 6 Jan 2007 13:46:39 -0500
Message-ID: <20070106184639.GC12543@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932074AbXAFSqm@vger.kernel.org Sat Jan 06 19:46:58 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932074AbXAFSqm@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3GZF-0006rl-7z
	for glk-linux-kernel-3@gmane.org; Sat, 06 Jan 2007 19:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXAFSqm (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 6 Jan 2007 13:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbXAFSqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:46:42 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:57243 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbXAFSql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:46:41 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:MCpjND9kqvwCPHeTyF/ReY8am60eV18S@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l06IkerP015316;
	Sat, 6 Jan 2007 13:46:40 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l06IkdB5015314;
	Sat, 6 Jan 2007 13:46:39 -0500
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36094>

Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
queues-like [1] functionality and interface to git.  The one distinguishing
feature from other quilt-like porcelains, is the format of the patches
directory. _All_ the information is stored as plain text - a series file and
the patches (one per file). This easily lends itself to versioning the
patches using any number of of SCMs.

Tarballs:
http://www.kernel.org/pub/linux/kernel/people/jsipek/guilt/

Git repository:
git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git


The code is licensed under GPLv2.

Of course, contributions and feedback are welcomed :)

Josef "Jeff" Sipek.

[1] http://www.selenic.com/mercurial/wiki/index.cgi/MqExtension
