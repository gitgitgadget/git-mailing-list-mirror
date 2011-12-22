From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Gitk: shortcut to jump to the current HEAD (yellow spot)?
Date: Thu, 22 Dec 2011 18:26:13 +0000
Message-ID: <874nwslayi.fsf@fox.patthoyts.tk>
References: <4EF3517A.8030108@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?iso-8859-1?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Thu Dec 22 19:26:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdnLR-0005Ia-ON
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 19:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab1LVS0S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Dec 2011 13:26:18 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:19677 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751892Ab1LVS0Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 13:26:16 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Dec 2011 13:26:16 EST
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111222182615.SQNC19823.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Thu, 22 Dec 2011 18:26:15 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RdnLL-0002s5-BL; Thu, 22 Dec 2011 18:26:15 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id E05472015A; Thu, 22 Dec 2011 18:26:14 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <4EF3517A.8030108@dirk.my1.cc> ("Dirk =?iso-8859-1?Q?S=FCsser?=
 =?iso-8859-1?Q?ott=22's?= message of
	"Thu, 22 Dec 2011 16:49:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=0ye2pr1Oh2AA:10 a=8nJEP1OIZ-IA:10 a=Rf460ibiAAAA:8 a=CfeYt0D733sVBer90p8A:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187613>

Dirk S=FCsserott <newsletter@dirk.my1.cc> writes:

>Hi!
>
>Does anybody know about a shortcut in gitk to "jump to the yellow spot=
"?
>
>I often use cmdline and gitk at the same time, switch branches, stash,
>rebase and so on from bash. When hitting [Ctrl-]F5 in gitk, the last
>highlighted commit is focused again and my HEAD is far off the screen.
>
>Is there a way to jump to the HEAD (the yellow bubble in gitk) with a
>fingertip?
>
>TIA
>    Dirk

Hit the Home key. The binding for that takes you to the first commit.
End to the last (oldest) commit.
--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
