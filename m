From: Kevin Smith <yarcs@qualitycode.com>
Subject: SCM ideas from 2003
Date: Mon, 18 Apr 2005 23:38:37 -0400
Message-ID: <42647D3D.6030906@qualitycode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 05:34:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNjVm-0004mF-PR
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 05:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVDSDiy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 23:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVDSDix
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 23:38:53 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:14741 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261309AbVDSDiw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 23:38:52 -0400
Received: from [10.10.10.20] (147-49.35-65.tampabay.res.rr.com [65.35.49.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id BA9E63C0A
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 03:38:43 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just stumbled across this page, dated 2003, which foreshadows a couple
of the decisions Linus has made for git:

  http://ydirson.free.fr/en/software/scm/vc.txt

Here are the parts that particularly caught my eye:

"what's so special about files ?" where the author suggests that
existing SCM systems are so blinded by the tradition of file orientation
that they can't see that there might be alternatives.

"As a goodie we can even note that moving a file inside the hierarchy
has become exactly similar as moving a code statement." where the author
recognizes that renames are merely a special case of code moves.

His implementation ideas are quite different from git, but I thought it
was pretty cool to find that someone was thinking about these ideas a
couple years ago.

Kevin
