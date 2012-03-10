From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Use PWD if it exists on Mac OS X.
Date: Sat, 10 Mar 2012 23:18:48 +0000
Message-ID: <877gys11uv.fsf@fox.patthoyts.tk>
References: <1331335042-25509-1-git-send-email-mk@acc.umu.se>
	<7vty1x2vod.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcus Karlsson <mk@acc.umu.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 14:51:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7S8N-0002df-QY
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355Ab2CMNvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:51:23 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:39509 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753592Ab2CMNvW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 09:51:22 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120313123557.SASS14668.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 13 Mar 2012 12:35:57 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1S7QxJ-0006sG-N6; Tue, 13 Mar 2012 12:35:57 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id EA9BF22B49; Sat, 10 Mar 2012 23:18:48 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vty1x2vod.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Mar 2012 15:37:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=d_KsGz-eqJ4A:10 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=Rf460ibiAAAA:8 a=NE1UYl_qaBzi58DN0MMA:9 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193027>

Junio C Hamano <gitster@pobox.com> writes:

>Thanks, Marcus.
>
>Just forwarding to the current maintainer; please note that my
>sign-off does not mean anything more than what D-C-O says it means;
>I rarely if ever use git-gui myself and do not have a Macintosh.

Thanks for this. I also don't have a Mac but this looks sensible
so applied.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
