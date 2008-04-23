From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Wrong help text on git status -h ?
Date: Wed, 23 Apr 2008 12:54:51 +0000 (UTC)
Message-ID: <loom.20080423T125136-135@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 14:56:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoeVu-000706-ST
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 14:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103AbYDWMzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 08:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757082AbYDWMzG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 08:55:06 -0400
Received: from main.gmane.org ([80.91.229.2]:53533 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757013AbYDWMzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 08:55:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JoeV1-0006Ai-EX
	for git@vger.kernel.org; Wed, 23 Apr 2008 12:54:59 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 12:54:59 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 12:54:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80213>

Hi all.

This is what I get:

~/src/git$ ./git version
git version 1.5.5.1.67.gbdb8


~/src/git$ ./git status -h
usage: git-status [options] [--] <filepattern>...

    -q, --quiet           be quiet
    -v, --verbose         be verbose

Commit message options
   [....]

Commit contents options
   [....]


(The [....] is deleted by me for this post!).

Getting help for commit on 'git status -h' can't be right, can it ?
Or am I missing something?

Thanks,
Stefan
