From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 0/4] git-svn.txt: miscellaneous changes
Date: Thu, 10 Oct 2013 06:59:47 +0000
Message-ID: <20131010065947.GB2413@dcvr.yhbt.net>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
 <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Keshav Kini <keshav.kini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 08:59:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUADv-0004SM-MM
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 08:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab3JJG7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 02:59:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37066 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618Ab3JJG7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 02:59:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70EB91F6D2;
	Thu, 10 Oct 2013 06:59:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235853>

Keshav Kini <keshav.kini@gmail.com> wrote:
> I'm not sure if this was the best way to split my changes into commits.
> Please let me know if it wasn't.
> 
> Keshav Kini (4):
>   git-svn.txt: fix AsciiDoc formatting error
>   git-svn.txt: reword description of gc command
>   git-svn.txt: replace .git with $GIT_DIR
>   git-svn.txt: elaborate on rev_map files
> 
>  Documentation/git-svn.txt | 46 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 13 deletions(-)

Good enough for me :)   Pushed to git-svn.git

The following changes since commit 128a96c98442524c7f2eeef4757b1e48445f24ce:

  Update draft release notes to 1.8.5 for the fifth batch of topics (2013-09-20 12:42:02 -0700)

are available in the git repository at:

  git://git.bogomips.org/git-svn.git master

for you to fetch changes up to 945b9c14ffd3e11c916ee2b2428a0b2be9645829:

  git-svn.txt: elaborate on rev_map files (2013-10-10 06:56:12 +0000)

----------------------------------------------------------------
Keshav Kini (4):
      git-svn.txt: fix AsciiDoc formatting error
      git-svn.txt: reword description of gc command
      git-svn.txt: replace .git with $GIT_DIR
      git-svn.txt: elaborate on rev_map files

Nicolas Vigier (1):
      git-svn: fix signed commit parsing

 Documentation/git-svn.txt | 46 +++++++++++++++++++++++++++++++++-------------
 git-svn.perl              |  2 +-
 2 files changed, 34 insertions(+), 14 deletions(-)
