From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: MinGW port - initial work uploaded
Date: Thu, 08 Feb 2007 09:22:58 -0800
Message-ID: <45CB5C72.8030002@zytor.com>
References: <200701192148.20206.johannes.sixt@telecom.at>	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>	 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>	 <46d6db660701221425i672e826coc9eef4bd8d22ae9d@mail.gmail.com>	 <45CADCB7.5050107@zytor.com> <46d6db660702080606u58a6233l61d1f56faf7eac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 18:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFCzy-0003AK-L1
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 18:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423239AbXBHRXV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 12:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423240AbXBHRXV
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 12:23:21 -0500
Received: from terminus.zytor.com ([192.83.249.54]:35433 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423239AbXBHRXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 12:23:20 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l18HMxdt009115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Feb 2007 09:23:00 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <46d6db660702080606u58a6233l61d1f56faf7eac3@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.88.7/2538/Thu Feb  8 06:37:31 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_12_24,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39065>

Christian MICHON wrote:
> I know that. I meant efficient alternative...

Heh, no kidding.

I'm delighted to see git ported more competently to lesser operating 
systems, as it makes it *so* much easier to push it as the SCM of 
choice.  A lot of places go with SVN or even (gack!) CVS because it's 
familiar and cross-platform.

	-hpa
