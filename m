From: "Cannizzo, Fabio" <Fabio.Cannizzo@sc.com>
Subject: QGIT questions/bugs
Date: Tue, 16 Jun 2009 22:09:25 +0800
Message-ID: <81D77A49EF91FF4FB63E5EB32416330F7239B1@HKMGAXMB104A.zone1.scb.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 16:09:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGZLy-0002wG-VH
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 16:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbZFPOJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 10:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbZFPOJZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 10:09:25 -0400
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:41878 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746AbZFPOJY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 10:09:24 -0400
Received: from source ([203.191.3.113]) (using TLSv1) by eu1sys200aob117.postini.com ([207.126.147.11]) with SMTP
	ID DSNKSjenlV5EpyrdQs61RaNcWb4Yk/z4Ot2I@postini.com; Tue, 16 Jun 2009 14:09:27 UTC
Received: from hkjumxcs101.zone1.scb.net (hkjumxcs101.zone1.scb.net [10.20.214.161])
	by rx576.standardchartered.com (8.12.11.20060308/8.12.8) with ESMTP id n5GE9Mff004012
	for <git@vger.kernel.org>; Tue, 16 Jun 2009 22:09:22 +0800
Received: from HKMGAXMB104V.zone1.scb.net ([10.20.203.20]) by hkjumxcs101.zone1.scb.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Jun 2009 22:09:22 +0800
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: QGIT questions/bugs
Thread-Index: AcnuigGoTEI2Dmw3SP6q86uJv6woiAAAcj1Q
X-OriginalArrivalTime: 16 Jun 2009 14:09:22.0254 (UTC) FILETIME=[0C1896E0:01C9EE8C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121683>


Hi

I have ben using qgit over the last few weeks and I think it is a great
tool. Very well thought designed. Thanks a lot for that.

1)
I have a problem using qgit. As you can see from the screenshot below,
when I select Working Dir, qgit shows all my files in the bottom right
pane.
However, if I do git status from the command line, there are no modified
files. 
I am launching qgit from the windows start menu, while I use the version
of git coming with cygwin to commit my files. Also, if this may matter,
I use linux end of line style.
Is there a way to configure qgit so that it displays only modified
files?

2) If I select by tree view, and select an individual file and that file
has been renamed, on the right pane I will be able to see only the
history up to the point where it was renamed. Is there a way to see the
full history (i.e. equivalent to git -follow)?

3) I often encounter a bug. When I open a repo, after a while qgit
crashes. It happens most of the time 5-10 seconds immediataly after I
have opened the repo, and is quite random. Do you have any suggestion on
how I could try to avoid it? I have tried to compress the repo, but it
has no impact.

Regards,
Fabio



This email and any attachments are confidential and may also be privileged.  If you are not the addressee, do not disclose, copy, circulate or in any other way use or rely on the information contained in this email or any attachments.  If received in error, notify the sender immediately and delete this email and any attachments from your system.  Emails cannot be guaranteed to be secure or error free as the message and any attachments could be intercepted, corrupted, lost, delayed, incomplete or amended.  Standard Chartered PLC and its subsidiaries do not accept liability for damage caused by this email or any attachments and may monitor email traffic.

 

Standard Chartered PLC is incorporated in England with limited liability under company number 966425 and has its registered office at 1 Aldermanbury Square, London, EC2V 7SB.

 

Standard Chartered Bank ("SCB") is incorporated in England with limited liability by Royal Charter 1853, under reference ZC18.  The Principal Office of SCB is situated in England at 1 Aldermanbury Square, London EC2V 7SB. In the United Kingdom, SCB is authorised and regulated by the Financial Services Authority under FSA register number 114276.

 

If you are receiving this email from SCB outside the UK, please click http://www.standardchartered.com/global/email_disclaimer.html to refer to the information on other jurisdictions.
