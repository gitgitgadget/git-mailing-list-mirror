From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: REQUEST-PULL: Please pull from git-gui.
Date: Sat, 18 Apr 2015 14:47:58 +0100
Message-ID: <87sibxsg35.fsf@red.patthoyts.tk>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 15:56:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjTEZ-0002oS-SR
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 15:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbbDRN4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 09:56:23 -0400
Received: from know-smtprelay-omc-10.server.virginmedia.net ([80.0.253.74]:41835
	"EHLO know-smtprelay-omc-10.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbbDRN4W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2015 09:56:22 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2015 09:56:21 EDT
Received: from red.patthoyts.tk ([82.45.42.101])
	by know-smtprelay-10-imp with bizsmtp
	id HRo01q0122AxhvW01Ro0hE; Sat, 18 Apr 2015 14:48:00 +0100
X-Originating-IP: [82.45.42.101]
X-Spam: 0
X-Authority: v=2.1 cv=dY0O3Bne c=1 sm=1 tr=0 a=FEdcR8KTC/yDun0iFnNZnw==:117
 a=FEdcR8KTC/yDun0iFnNZnw==:17 a=Rf460ibiAAAA:8 a=6gpmbu8EOFEA:10
 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10 a=FP58Ms26AAAA:8 a=1oJP67jkp3AA:10
 a=ZZnuYtJkoWoA:10 a=e9J7MTPGsLIA:10 a=-AnQz9JOAAAA:8 a=2TLsYSGkLdJdT1FQHQcA:9
 a=QEXdDO2ut3YA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2a01:348:2be::2])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id 607661962DB8;
	Sat, 18 Apr 2015 14:47:59 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267419>

The following changes since commit 1b2c79e63e5afa3cecb3ab4a40cb414dbe65=
11ce:

  git-gui 0.19 (2014-01-18 17:29:34 +0000)

are available in the git repository at:

  http://repo.or.cz/r/git-gui.git tags/gitgui-0.20.0

for you to fetch changes up to 4498b3a50a0e839788682f672df267cbc1ba9292=
:

  git-gui: set version 0.20 (2015-04-18 12:15:32 +0100)

----------------------------------------------------------------
git-gui 0.20.0

----------------------------------------------------------------
Alexander Shopov (2):
      git-gui i18n: Updated Bulgarian translation (520t,0f,0u)
      git-gui i18n: Updated Bulgarian translation (547t,0f,0u)

Csaba Kiraly (1):
      git-gui: fix problem with gui.maxfilesdisplayed

David Turner (1):
      git-gui: Make git-gui lib dir configurable at runime

Henri GEIST (1):
      git-gui: Add a 'recursive' checkbox in the clone menu.

Jens Lehmann (2):
      git-gui: show staged submodules regardless of ignore config
      git-gui: tolerate major version changes when comparing the git ve=
rsion

Kyle J. McKay (1):
      git-gui: reinstate support for Tcl 8.4

Michael Lutz (1):
      git-gui: add configurable tab size to the diff view

Pat Thoyts (4):
      git-gui: align the new recursive checkbox with the radiobuttons.
      Merge remote-tracking branch 'vnwildman/master'
      git-gui: fix verbose loading when git path contains spaces.
      git-gui: set version 0.20

Peter Krefting (1):
      git-gui: sv.po: Update Swedish translation (547t0f0u)

Remi Rampin (2):
      git-gui: Fixes chooser not accepting gitfiles
      git-gui: Makes chooser set 'gitdir' to the resolved path

Sebastian Schuberth (1):
      git-gui/gitk: Do not depend on Cygwin's "kill" command on Windows

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      L10n: vi.po (543t): Init translation for Vietnamese

 GIT-VERSION-GEN           |    2 +-
 Makefile                  |    3 +-
 git-gui.sh                |   48 +-
 lib/choose_repository.tcl |   55 +-
 lib/diff.tcl              |   23 +-
 lib/option.tcl            |    1 +
 macosx/AppMain.tcl        |    7 +-
 po/bg.po                  |  650 ++++-----
 po/sv.po                  | 3389 +++++++++++++++++++++++--------------=
--------
 po/vi.po                  | 2690 +++++++++++++++++++++++++++++++++++
 10 files changed, 4896 insertions(+), 1972 deletions(-)
 create mode 100644 po/vi.po
