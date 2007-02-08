From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: MinGW port - initial work uploaded
Date: Thu, 08 Feb 2007 09:18:55 -0800
Message-ID: <45CB5B7F.6010707@zytor.com>
References: <200701192148.20206.johannes.sixt@telecom.at>  <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>  <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>  <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>  <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org> <fcaeb9bf0701232312t5889efa6w58bb3abfa2f53ebd@mail.gmail.com> <Pine.LNX.4.64.0701240834190.3606@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian MICHON <christian.michon@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 18:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFCvl-000159-Nj
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 18:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423234AbXBHRTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 12:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965732AbXBHRTa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 12:19:30 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33049 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965731AbXBHRT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 12:19:29 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l18HIt5X008930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Feb 2007 09:18:56 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <Pine.LNX.4.64.0701240834190.3606@woody.linux-foundation.org>
X-Virus-Scanned: ClamAV 0.88.7/2538/Thu Feb  8 06:37:31 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.4 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_12_24 autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39064>

Linus Torvalds wrote:
> 
> Ahh, that's perfect. There are even RPM's for mingw around, since that 
> seems to be what some Wine people use for testing.
> 

I've been using MinGW on Linux since the Transmeta days to build Win32 
binaries on Linux.  It's *really* handy, and it's how I produce the 
Win32 version of syslinux.

	-hpa
