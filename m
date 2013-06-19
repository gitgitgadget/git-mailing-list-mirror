From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH 0/2] Update linux-2.6.git location and repo size
Date: Tue, 18 Jun 2013 21:55:20 -0400
Message-ID: <cover.1371606791.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 19 04:56:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up8ZN-0001WD-GA
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934138Ab3FSC4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:56:21 -0400
Received: from vms173011pub.verizon.net ([206.46.173.11]:54752 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934131Ab3FSC4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:56:19 -0400
X-Greylist: delayed 3604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2013 22:56:19 EDT
Received: from odin.tremily.us ([unknown] [72.68.80.181])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MOM00KI9AP4BT50@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 18 Jun 2013 20:55:57 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id AC81EA3A711; Tue,
 18 Jun 2013 21:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1371606952; bh=Er9HpAiK9/jmhICphdvJEGZzCjatHvVlGZgGyLz4dp0=;
	h=From:To:Cc:Subject:Date;
	b=DdvYvOthrie6eFNfTTl57/ChzLgaOCqDTnza54bCxsrwTHzXdxfE+oYJp5kblwAsR
 G3EZJd8HoEQ7+kZ7fZY2phHJ8VWoE/zkVHQUsJOz0/rGSvqw/XTLw5BuZgUG9+NTzV
 m21vfucR3UzsfmUSfr878pGWIzp32m4OsQ0B4XNo=
X-Mailer: git-send-email 1.8.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228333>

From: "W. Trevor King" <wking@tremily.us>

Bring the docs back up to date with the real world ;).  Patches are
against the current gitster/maint.  The commit messages may be to
chatty, so let me know if you'd like a trimmed down version.

W. Trevor King (2):
  Documentation: Update 'linux-2.6.git' -> 'linux.git'
  user-manual: Update download size for Git and the kernel

 Documentation/git-clone.txt       |  2 +-
 Documentation/git-fast-export.txt |  2 +-
 Documentation/user-manual.txt     | 10 +++++-----
 t/perf/README                     |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.8.3
