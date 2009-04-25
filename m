From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH 0/2] Documentation: git-clean: description updates
Date: Sat, 25 Apr 2009 09:13:39 -0600
Message-ID: <1240672421-10309-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 17:15:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxjbC-0005Hn-47
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 17:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbZDYPNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 11:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbZDYPNu
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 11:13:50 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:46677 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751384AbZDYPNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 11:13:49 -0400
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id B81A63659C;
	Sat, 25 Apr 2009 09:13:44 -0600 (MDT)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id 2E7F52938B0;
	Sat, 25 Apr 2009 09:13:42 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 54CE32FD57; Sat, 25 Apr 2009 09:13:41 -0600 (MDT)
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117556>

I stumbled over the git-clean documentation when I was first learning
git, and ran into this again when a colleage was asking for help. So
here are two fixes.

The first patch fixes some minor grammatical errors in very
non-intrusive manner. This should be completely uncontroversial.

The second patch rewrites the first paragraph in the description
section to make it more readable and friendly. I think this change
is a very good one, but I split it into a separate patch since it is
a more intrusive change.

Wesley J. Landaker (2):
  Documentation: git-clean: fix minor grammatical errors
  Documentation: git-clean: make description more readable

 Documentation/git-clean.txt |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)
