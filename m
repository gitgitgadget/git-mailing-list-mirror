From: Scott Chacon <schacon@gmail.com>
Subject: git-scm.com refresh
Date: Fri, 4 May 2012 16:29:33 -0700
Message-ID: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 05 01:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQRwp-0006le-3G
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 01:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760604Ab2EDX35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 19:29:57 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:34198 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760601Ab2EDX34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 19:29:56 -0400
Received: by qabj40 with SMTP id j40so2161880qab.1
        for <git@vger.kernel.org>; Fri, 04 May 2012 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=QMrA7p/eZRUseYqBjfS48Mk/rxcP1fATxhfFKN71Ot4=;
        b=X0zBamxauBmsBYtROPKu3GT1RONVglSe30qiwlE+nCOFJ6Vp5KCUa3ODlSmEinWXic
         UI41u1TPdDrDC+u0kvo9Ojv6N2WoX5A5fH6WF8Mbxcsqr9m0TG4uEXkrTnvuqYEFN60S
         gk3QfIeJGofHoWhrbdA7YrWleMdUB9dPXuk+qJzxztLtjHZI67fBiBUaDqBfDn3fUN2E
         byoL6DSDQjc6eEFgF5HVwKmRLUDMXTNAojf/iKX5Hpd+DiFN+bXGRIi8BuJ5D7PRoLoH
         YWSTLS+1lIL+nDXY0mUgVDUhmEsdNRiO1JYf+uzOct3oR9NYd3w1PLHdgvGt6dFP5GaL
         RbHw==
Received: by 10.224.78.82 with SMTP id j18mr5100933qak.10.1336174193460; Fri,
 04 May 2012 16:29:53 -0700 (PDT)
Received: by 10.229.163.210 with HTTP; Fri, 4 May 2012 16:29:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197082>

Hey everyone,

I just shipped a big update to the git-scm.com website, incorporating
tons of feedback I've gotten on the site, especially from new users,
over the years.  I think it will help new users to Git find the right
installer and get up and running easier.  I have other ideas of things
to add to it in the future, but I think this is much better than the
site that has served us well for a few years now.

Some other interesting things to note:

* There is now permanent man page hosting here, for example:
http://git-scm.com/docs/git-fsck.  You can also reference any older
version of any command: http://git-scm.com/docs/git-fsck/1.5.5

* We designed a new logo[1] - there are multiple variations available
for download on the site under the most permissive CC license for any
use.

* The Pro Git book (and all of it's translations) has been directly
incorporated into the site and has better permalinks and section
anchors.  progit.org will soon be redirecting to git-scm.com.

* Matthew McCullough has started a video series[2] for newbies and
will continue to do more developer and intermediate type videos as
well.

* There are still a few asciidoc parsing issues that we're working on
- if you find anything that's weird please report it at our issue
tracker: https://github.com/github/gitscm-next/issues

Let me know if you run into anything or there are any features you
would like to see.  Also, be sure to thank Jason Long for doing all
the design for the site, including the new logo
(https://github.com/blackant).

Scott

[1] http://git-scm.com/downloads/logos
[2] http://git-scm.com/videos
