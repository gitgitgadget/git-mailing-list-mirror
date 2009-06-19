From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Windows 7 and git-gui/gitk language
Date: 19 Jun 2009 21:43:58 +0100
Message-ID: <873a9w0x9t.fsf@users.sourceforge.net>
References: <alpine.DEB.2.00.0906181200460.23400@ds9.cixit.se>
	<87fxdw0zin.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHkzV-0004jL-Ga
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 22:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760546AbZFSUoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 16:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760543AbZFSUn7
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 16:43:59 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:32912 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760381AbZFSUn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 16:43:58 -0400
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MHkwK-0008FA-9K; Fri, 19 Jun 2009 21:44:00 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MHkwJ-000361-Rm; Fri, 19 Jun 2009 21:43:59 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 5B50D51842; Fri, 19 Jun 2009 21:43:59 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <87fxdw0zin.fsf@users.sourceforge.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121910>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

More follow-up -- it is actually the registry package missing from the
msysGit version of tcl which causes the fault. msysGit issue 283 is
now raised for this.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
