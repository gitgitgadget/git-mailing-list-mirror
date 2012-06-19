From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 0/3] sync German translation of git-gui with git-core
Date: Tue, 19 Jun 2012 23:02:05 +0100
Message-ID: <87pq8v2c6a.fsf@fox.patthoyts.tk>
References: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stimming@tuhh.de, trast@student.ethz.ch, jk@jk.gs,
	git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 00:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh6Xm-0002Wz-Vy
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 00:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191Ab2FSWE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 18:04:58 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:59951 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754893Ab2FSWE5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 18:04:57 -0400
Received: from know-smtpout-1.server.virginmedia.net ([62.254.123.1])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120619220455.NHZP3118.mtaout01-winn.ispmail.ntl.com@know-smtpout-1.server.virginmedia.net>;
          Tue, 19 Jun 2012 23:04:55 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-1.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Sh6Ux-0001Wj-AL; Tue, 19 Jun 2012 23:02:07 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 9B8DF235DD; Tue, 19 Jun 2012 23:02:06 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1340130341-5224-1-git-send-email-ralf.thielow@googlemail.com>
	(Ralf Thielow's message of "Tue, 19 Jun 2012 20:25:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=yXKpQpivER4A:10 a=CtgcEeagiGAA:10 a=8nJEP1OIZ-IA:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=NUa8ojXfPKlhTkParv4A:9 a=wPNLvfGTeEIA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200259>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

>We should keep the translation of the tools in sync with
>git-core. So this patch series sync the German translation
>of git-gui with the git-core one.
>
>Ralf Thielow (3):
>  git-gui: de.po: consistently add untranslated hook names within
>    braces
>  git-gui: de.po: translate "bare" as "blo=DF"
>  git-gui: de.po: translate "remote" as "extern"
>
> po/de.po | 36 ++++++++++++++++++------------------
> 1 Datei ge=E4ndert, 18 Zeilen hinzugef=FCgt(+), 18 Zeilen entfernt(-)

Thank you for this -- applied and pushed.
--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
