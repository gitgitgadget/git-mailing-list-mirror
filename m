From: Hocapito Cheteamo <hocapitocheteamo@yahoo.com>
Subject: Error on git clone
Date: Tue, 5 Oct 2010 21:20:18 -0700 (PDT)
Message-ID: <193301.7835.qm@web114608.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 06:20:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3LUQ-0004Ii-LC
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 06:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab0JFEUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 00:20:20 -0400
Received: from web114608.mail.gq1.yahoo.com ([98.136.183.45]:22945 "HELO
	web114608.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752847Ab0JFEUT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 00:20:19 -0400
Received: (qmail 9911 invoked by uid 60001); 6 Oct 2010 04:20:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1286338819; bh=NFO1OLLrZOrAR1IY2uFEoG3Hv+z1MjBgroYfvLYthIc=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=N2/mZS3TM3zJiHwWLQcL7z64DiaG9ukbaJCxP/Wah85jKwSX8JiHmPwdxs1eGur1IfJ04DGzAns84aCv9BF+Dvr8fu3zriMfu9mJo3U93KafxJSw9mIjuI3W9GmBbqXnnMOX73nDI/jeIcUp8f0969tRc3bGC1sgF1VVzC+VYlg=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=mXKuPFHT8vmUEc2jgB0+no13NnuE8CJr4lUHd9FUqL8MwJtdoZ7zq7e+FFphs+/eI9t+B+WffE/4r+i/8AEl/7Fddp2NkRtublXX8ulYYeuBftTzus6GDPvG67mv8Xc3JmxKhF64AMOrUlZM24gKZ5dxDGkFdii7hP/JmMfh7b8=;
X-YMail-OSG: tj4ZShMVM1n11l4pN3NkPrNl1T.66xQIHqiFQf4A3cegUrN
 aD.EanBG7tR0e7OXNzcZgEcOECYVMKmDGfMNEWT7J2TrQAs8r.o6Zb1i4L72
 mDg8cZUiNTUa6E5E5JUK7UAERwagpKjDPScv1tR6LXtJjjLvF3iHeGhBDYTR
 2yLMRa7.3gNFJ9kOU2noR7bgGlPG8_g2Q.8EgyZFHN_IAcTlhLzwRyhV4nc_
 ROW6Wg5ABZ_ONOs4J5VUr6ovy5DbOMv2ZCOb2pIo2VZxfkcxACT1Ro2dB5I8
 H83cEMg--
Received: from [76.83.7.252] by web114608.mail.gq1.yahoo.com via HTTP; Tue, 05 Oct 2010 21:20:18 PDT
X-Mailer: YahooMailRC/497 YahooMailWebService/0.8.105.279950
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158264>

Hi,

I'm a newbie on using git. I installed Git 1.7.0.2 on my PC laptop running 
Windows XP Prof. SP 2.  When I run the command,
    "git clone git@github.com:......git sss", 
I got these log messages:

Initialized empty Git repository in c:/...../.git/
Enter passphrase for key 'C:\.....\privateKey':
remote: Counting objects: 478, done.
remote: Compressing objects: 100% (303/303), done.
remote: Total 478 (delta 21), reused 436 (delta 3)
Receiving objects: 100% (478/478), 96.57 MiB | 148 KiB/s, done.
Resolving deltas: 100% (21/21), done.
tagging': Invalid argumenttory at 'public/images/tagging

Does anyone have any clue on what this "Invalid argumenttory" error is all 
about?  It did not finish unpacking all the files in folder sss.  It aborted 
after this error.  Thanks so much for the help.

Hoca.


      
