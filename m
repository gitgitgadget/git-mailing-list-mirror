From: "MS-Informatique" <info@ms-informatique.be>
Subject: Bug report Windows 10
Date: Mon, 10 Aug 2015 14:26:44 +0200
Message-ID: <017101d0d367$d2009490$7601bdb0$@ms-informatique.be>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 14:26:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOmAI-0002ad-0G
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 14:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbbHJM0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 08:26:49 -0400
Received: from mailrelay4.public.one.com ([195.47.247.71]:54972 "EHLO
	mailrelay4.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbbHJM0s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 08:26:48 -0400
X-HalOne-Cookie: 014195e33c6b5d58545587992d4b5e0e4408ccab
X-HalOne-ID: 106fa650-3f5b-11e5-b2c2-b8ca3afa9d73
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=ms-informatique.be; s=20140924;
	h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding;
	bh=90TQmP2Tv4IB3Xr0CSUCimvY/cYsKbDRgNmthWX4qJA=;
	b=KcMXiYuOVSy3bKYSRfuQmcby7UHHshy1pEs4x/yVSSeWn/44tmix44Eg/iZFOiAzET9U0+3VnWXnX
	 Rd5HphnRslPApjGQ+Lvf0xA3SMGW3BKWOfJdpQhzGfcrIfiBpT7xvyOClK/d61L4myBXS1zGgF3Jfh
	 4rsm2Xi3U5fUwqDw=
Received: from PortAsusMichel (unknown [85.201.221.86])
	by smtpfilter1.public.one.com (Halon Mail Gateway) with ESMTPA
	for <git@vger.kernel.org>; Mon, 10 Aug 2015 12:26:45 +0000 (GMT)
X-Mailer: Microsoft Outlook 15.0
Content-Language: fr
Thread-Index: AdDTZ9GWrRMVovvDRVeBu3qKR7EXfg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275611>

My Windows notebook got updated to Windows 10 and now my Git Bash doesn't
start and when I open an existing repository from Git Gui, I am getting next
error: 
"0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32 error 487
AllocationBase 0x0, BaseAddress 0x68570000, RegionSize 0x410000, State
0x10000
C:\Program Files (x86)\Git\bin\sh.exe: *** Couldn't reserve space for
cygwin's heap, Win32 error 0"

I am running GIT version 1.9.5 (latest build for Windows).

Can someone help me?

Thanks for your reply.

Regards,
Michel.
