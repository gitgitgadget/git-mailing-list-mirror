From: Peter Vereshagin <peter@vereshagin.org>
Subject: 'show' pretty %B without a diff
Date: Mon, 20 Dec 2010 10:38:42 +0300
Organization: '
Message-ID: <20101220073842.GC10354@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 08:50:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUaVS-0006Sy-C1
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 08:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab0LTHqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 02:46:49 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:52427 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab0LTHqs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 02:46:48 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Dec 2010 02:46:48 EST
Received: from localhost (unknown [199.48.147.42])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 7C2B75A82
	for <git@vger.kernel.org>; Mon, 20 Dec 2010 10:21:35 +0300 (MSK)
Content-Disposition: inline
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163986>

Hey Mr(s) git show some good to me!

I'd like to output a comment in my script.
Thus, I try: 'git show --format="%B" commitId'
There is always diff in the end of the output. No matter what format I specify, even when it is empty.
How can I avoid diff output in the 'git show'?
Thank you.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
--
http://vereshagin.org
