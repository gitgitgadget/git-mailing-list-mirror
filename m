From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: REQUEST-PULL: Please pull from git-gui.
Date: Sat, 18 Jan 2014 17:38:59 +0000
Message-ID: <871u051970.fsf@fox.patthoyts.tk>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 18:44:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Zww-0002JN-6K
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 18:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbaARRoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 12:44:46 -0500
Received: from know-smtprelay-omc-10.server.virginmedia.net ([80.0.253.74]:44826
	"EHLO know-smtprelay-omc-10.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaARRoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jan 2014 12:44:44 -0500
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jan 2014 12:44:43 EST
Received: from fox.patthoyts.tk ([82.34.175.55])
	by know-smtprelay-10-imp with bizsmtp
	id FVez1n00W1C56nm01Vezs3; Sat, 18 Jan 2014 17:39:00 +0000
X-Originating-IP: [82.34.175.55]
X-Spam: 0
X-Authority: v=2.1 cv=Qfbov6rv c=1 sm=1 tr=0 a=g1XlTrwDEGH9N8TSFs8Bjw==:117
 a=g1XlTrwDEGH9N8TSFs8Bjw==:17 a=qRKFtABOsx0A:10 a=vyW3ZBQhmXIA:10
 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10 a=FP58Ms26AAAA:8 a=SGAZK7grUXsA:10
 a=-AnQz9JOAAAA:8 a=Rf460ibiAAAA:8 a=oEq2oal9xFtwQI4jp-YA:9 a=CjuIK1q_8ugA:10
 a=AkUkIWUyXwcA:10 a=NWVoK91CQyQA:10
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 5A85522461; Sat, 18 Jan 2014 17:38:59 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240649>

The following changes since commit
1b2c79e63e5afa3cecb3ab4a40cb414dbe6511ce:

  git-gui 0.19 (2014-01-18 17:29:34 +0000)

are available in the git repository at:

  http://repo.or.cz/r/git-gui.git tags/gitgui-0.19.0

for you to fetch changes up to 1b2c79e63e5afa3cecb3ab4a40cb414dbe6511ce:

  git-gui 0.19 (2014-01-18 17:29:34 +0000)

----------------------------------------------------------------
git-gui 0.19.0

----------------------------------------------------------------

This includes the following commits that are not already merged into the
main git repository. 02f6cfb is important as it fixes an earlier commit
that will prevent git-gui running with Tk 8.4.

1b2c79e git-gui 0.19
c64a0ad git-gui: chmod +x po2msg, windows/git-gui.sh
02f6cfb git-gui: fallback right pane to packed widgets with Tk 8.4
1ea11f0 git-gui i18n: Added Bulgarian translation
15a7453 git-gui l10n: Add 29 more terms to glossary
99337ef git-gui i18n: Initial glossary in Bulgarian

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
