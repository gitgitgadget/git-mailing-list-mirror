From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [BUG] git gui blame: Show History Context [still] broken since 29e5573d
Date: Sun, 25 Jul 2010 21:19:44 +0100
Message-ID: <87iq43wbz3.fsf@fox.patthoyts.tk>
References: <vpqy6e4v1h0.fsf@bauges.imag.fr> <87sk3qrjk3.fsf@fox.patthoyts.tk>
	<7vtyo4a096.fsf@alter.siamese.dyndns.org>
	<vpqzkxkorzr.fsf@bauges.imag.fr> <20100722082310.GB13386@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, spearce@spearce.org,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 22:20:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7ge-000846-3T
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 22:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390Ab0GYUUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 16:20:25 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:39787 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751884Ab0GYUUG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 16:20:06 -0400
Received: from [172.23.170.136] (helo=anti-virus01-07)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Od7fy-00031w-51; Sun, 25 Jul 2010 21:19:58 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Od7fl-0004i5-PG; Sun, 25 Jul 2010 21:19:45 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id E291322B77; Sun, 25 Jul 2010 21:19:44 +0100 (BST)
X-Url: http://www.patthoyts.tk/
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
In-Reply-To: <20100722082310.GB13386@burratino> (Jonathan Nieder's message of "Thu\, 22 Jul 2010 03\:23\:10 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151792>

Jonathan Nieder <jrnieder@gmail.com> writes:

>Matthieu Moy wrote:
>
>> Too late for the 1.7.2, but can we finally get one of these patches
>> applied? They're both very short and straightforward, and fix an
>> important feature of git-gui which is basically broken as of now.
>
>Maybe some interested person should maintain a temporary fork of
>git-gui that could be merged in the meantime.  That is what people
>seem to usually do with submodules in analogous situations.

I pushed git-gui + my patches to git://git.patthoyts.tk/git-gui
(http://www.patthoyts.tk/gitweb.cgi?p=git-gui;a=summary)
so if someone wants to pull from that it is Shawn's repository plus 3.

Alternatively the git-gui patches could be pulled from msysGit which
has a few in addition to these three.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
