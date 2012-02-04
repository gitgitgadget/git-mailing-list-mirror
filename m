From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Git-gui: crashes on OS X when entering combining ("dead") keys
Date: Sat, 04 Feb 2012 23:07:15 +0000
Message-ID: <871uqafba4.fsf@fox.patthoyts.tk>
References: <4F2B085C.2000508@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Beat Bolli <ig@drbeat.li>
X-From: git-owner@vger.kernel.org Sun Feb 05 00:07:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtohZ-0000Ud-Uc
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 00:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768Ab2BDXHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 18:07:20 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:40572 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753444Ab2BDXHT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 18:07:19 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.3])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120204230716.ZFAU7151.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 4 Feb 2012 23:07:16 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RtohQ-0004F7-IF; Sat, 04 Feb 2012 23:07:16 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id B177B22533; Sat,  4 Feb 2012 23:07:15 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <4F2B085C.2000508@drbeat.li> (Beat Bolli's message of "Thu, 02
	Feb 2012 23:04:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=U3iy7AdifpMA:10 a=kj9zAlcOel0A:10 a=Rf460ibiAAAA:8 a=eWogn9lfTgJJcA6HyGIA:9 a=CjuIK1q_8ugA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189918>

Beat Bolli <ig@drbeat.li> writes:

>Hi
>
>I've just had git-gui crash on me when I tried to enter the ~ (tilde)
>character on my Mac mini under OS X 10.6.8:
>

This doesn't look git-gui specific so you will likely get more results
posting to the comp.lang.tcl newsgroup about this - or there is a
mac-specific tcl/tk list someplace.

Not posessing a Mac I can't look into this at all - but an
NSException -- that is a problem from the Tk to native layer.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
