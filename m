From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Set both 16x16 and 32x32 icons on X to pacify Xming.
Date: Wed, 07 Dec 2011 14:36:37 +0000
Message-ID: <877h2878ju.fsf@fox.patthoyts.tk>
References: <1321640015-6663-1-git-send-email-naesten@gmail.com>
	<CAJYzjmcsGQ8xxmOEvDCZGyT5e=gKkjC7fDxdcbNg4FZRddERpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 16:39:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYJaZ-0006d5-UG
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 16:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab1LGPjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 10:39:15 -0500
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:7700 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756478Ab1LGPjO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 10:39:14 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111207143638.GSDQ17949.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Wed, 7 Dec 2011 14:36:38 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RYIbu-00041K-Rc; Wed, 07 Dec 2011 14:36:38 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id CBB8820A64; Wed,  7 Dec 2011 14:36:37 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CAJYzjmcsGQ8xxmOEvDCZGyT5e=gKkjC7fDxdcbNg4FZRddERpw@mail.gmail.com>
	(Samuel Bronson's message of "Tue, 29 Nov 2011 19:02:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=7iSKs-8F63kA:10 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=Rf460ibiAAAA:8 a=Zsq_wg3XOTwULfcddWsA:9 a=CjuIK1q_8ugA:10 a=MSl-tDqOz04A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186465>

Samuel Bronson <naesten@gmail.com> writes:
>
>Hmm. Nothing seems to have happened with this patch yet. Any
>suggestions on how to bring it to the attention of the git-gui people?

I got around to checking this with xmingw and it makes sense so it's
committed now.
Thanks.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
