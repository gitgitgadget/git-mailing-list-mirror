From: Semyon Vadishev <semen.vadishev@tmatesoft.com>
Subject: [ANN] SubGit 2.0 Released
Date: Mon, 05 Aug 2013 20:06:35 +0200
Message-ID: <51FFE9AB.9050708@tmatesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: JGit developer discussion <jgit-dev@eclipse.org>,
	EGit developer discussion <egit-dev@eclipse.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 05 20:06:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6PB6-0007HT-Vu
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 20:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab3HESGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 14:06:41 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:56749 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754387Ab3HESGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 14:06:39 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so1773652eaj.39
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 11:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=XE+JloMvnID056ZVdjUTvz/2xEjmVEXudXhSSPVsaeY=;
        b=Q9MaqS7JKtMtfHUReX+IxTL6vptt+s86Wr2bZm1UPCzehys+M9+ehZRWJYI3DFjKQg
         /loj1yYl4Rf3t29+w7PVMkrrUuSft/Tm+QLfKDRivfkizDhUVJ8NpQKfmjLMwr8OkJLW
         gmiOAjbUAzxdmoPe+0bIufqtY9hRdMvW+8YGgrnxiuPLBloZ35qUfTvZ7ijm+9GeLOGU
         gVz2vCBQkaOqn4ZDmnIGU/xxgfdDAL65d7DCh/YJM6IYo1ht6CQM2CwbaWFKwwL4tfnp
         PD4kSuZnP9/eBlbAJxEQTubS9yLawjvWLR4zVQsNZmojH0g4+bwYy167NrjZSaa/eOgH
         E3sw==
X-Received: by 10.15.49.72 with SMTP id i48mr17845611eew.37.1375725997729;
        Mon, 05 Aug 2013 11:06:37 -0700 (PDT)
Received: from vs.local (46.226.broadband11.iol.cz. [90.178.226.46])
        by mx.google.com with ESMTPSA id v41sm449182eep.10.2013.08.05.11.06.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 Aug 2013 11:06:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231685>

Hello all,

Our team is proud to announce SubGit 2.0.0 release! New version is
available for download at SubGit web site at http://subgit.com/

SubGit lets one to set up a bi-directional Git-SVN mirror, and thus it
allows users to choose freely between Subversion and Git version control
systems. SubGit is a perfect tool for those who's going to migrate from
Subversion to Git as well as from Git to SVN.

New version introduces the following major features:

1. Support for remote Subversion repositories;
2. One-shot import from Subversion to Git;
3. Flexible branches and tags layout;
4. Significant performance improvements.

SubGit is a closed source Java application, which is free for use in
Open Source and Academic projects, as well as in any teams with up to 10
committers. Besides, there are no limitations on the time you may
evaluate SubGit in commercial or closed source projects.

Atlassian Stash users can install SVN Mirror Add-on which is based on
SubGit 2.0, so they can manage their Git-SVN mirrors right from Stash
UI:
https://marketplace.atlassian.com/plugins/org.tmatesoft.subgit.stash-svn-importer

For the detailed release notes please refer to
http://subgit.com/documentation/release-notes.html
Documentation on remote Git-SVN mirror mode: http://subgit.com/book-remote/
Documentation on local Git-SVN mirror mode: http://subgit.com/book/
Documentation on one-shot Git-SVN import:
http://subgit.com/book-remote/#import
SubGit Issues Tracker: http://issues.tmatesoft.com/issues/SGT
Follow us at https://twitter.com/subgit and
https://plus.google.com/114128677298030695536

With Best Regards,
Semyon Vadishev on behalf of SubGit Team,
TMate Software,
http://subgit.com/ - Git-SVN Mirror!
http://svnkit.com/ - Java [Sub]Versioning Library!
http://hg4j.com/ - Java Mercurial Library!
http://sqljet.com/ - Java SQLite Library!
