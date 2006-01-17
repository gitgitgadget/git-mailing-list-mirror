From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [kernel.org users] [RFC] "clone --naked"?
Date: Tue, 17 Jan 2006 08:58:59 +0100
Organization: Universitaet Regensburg, Klinikum
Message-ID: <43CCB1D3.10309.35645D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <1137402365.3034.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	users@kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 09:00:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyllV-0003YO-Nu
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 09:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWAQIAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 03:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWAQIAA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 03:00:00 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:36528 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751300AbWAQH77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 02:59:59 -0500
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id C74E81710D;
	Tue, 17 Jan 2006 08:59:52 +0100 (CET)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id 5F070170C5;
	Tue, 17 Jan 2006 08:59:52 +0100 (CET)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.1/8.13.1/20050204MT-1) with ESMTP id k0H7xNOG001330;
	Tue, 17 Jan 2006 08:59:30 +0100
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    17 Jan 06 08:59:49 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 17 Jan 06 08:59:07 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-reply-to: <Pine.LNX.4.64.0601161114080.13339@g5.osdl.org>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=114364@20060117.075923Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14784>

Hi!

Maybe let me clarify: I don't have anything against any of those particular words. 
My original intention was that I thought them to be little descriptive regarding 
their function. You seem to have "--bare" and "--naked". Hard to guess what they 
really do.  The suggestion to select better words was not primarily because of 
underaged using Linux or any SPAM issues. That part was just a joke. Sorry.

Regards,
Ulrich


On 16 Jan 2006 at 11:17, Linus Torvalds wrote:

> 
> 
> On Mon, 16 Jan 2006, Arjan van de Ven wrote:
> > 
> > While I don't give a rats bottom about the "21"-ness of naked, "naked"
> > is more likely to trigger spam traps than "bare" though... just a side
> > consideration but unfortunately needed nowadays ;(
> 
> Yeah. I've had spamassassin kill patches to the aic7xxx driver because the 
> subject said "aic7xxx", and the "xxx" triggered as being a bad word.
> 
> Now, "naked" doesn't seem to trigger anything for spamassassin, but I 
> wouldn't be entirely surprised if some web-content blocker were to be 
> over-eager at times. So "bare" might be safer.
> 
> 		Linus
> 
> _______________________________________________
> Users mailing list
> Users@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/users
