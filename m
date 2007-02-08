From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: MinGW port - initial work uploaded
Date: Thu, 08 Feb 2007 00:17:59 -0800
Message-ID: <45CADCB7.5050107@zytor.com>
References: <200701192148.20206.johannes.sixt@telecom.at>	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>	 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org> <46d6db660701221425i672e826coc9eef4bd8d22ae9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 08 09:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4U5-0005Ie-KW
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161481AbXBHISW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 03:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422936AbXBHISW
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:18:22 -0500
Received: from terminus.zytor.com ([192.83.249.54]:53675 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161481AbXBHISV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 03:18:21 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l188HxuQ018610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Feb 2007 00:18:00 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <46d6db660701221425i672e826coc9eef4bd8d22ae9d@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.88.7/2534/Wed Feb  7 19:28:17 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.1 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_06_12,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39044>

Christian MICHON wrote:
> 
> the only recent alternative on Windows I came with was to run git
> through coLinux and share directories using cofs.
> 

Actually, git has been working on Cygwin for years.

	-hpa
