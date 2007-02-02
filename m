From: SungHyun Nam <goweol@gmail.com>
Subject: Re: GIT+CYGWIN annoying test failure
Date: Fri, 02 Feb 2007 09:10:53 +0900
Message-ID: <45C2818D.4020408@gmail.com>
References: <45B6C1FB.7060005@gmail.com> <Pine.LNX.4.63.0701241041190.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BD4AA9.5090400@gmail.com> <Pine.LNX.4.63.0702011703280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 02 01:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCm1C-0003aQ-A5
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 01:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbXBBALB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 19:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423029AbXBBALB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 19:11:01 -0500
Received: from relaygw1.kornet.net ([61.74.75.196]:52333 "EHLO
	relaygw1.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423026AbXBBALA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 19:11:00 -0500
Received: from [211.48.62.136] ([211.48.62.136]) 
          by relaygw1.kornet.net ([61.74.75.196]) 
          with ESMTP id 2007020209:10:55:587538.19779.133610416
          Fri, 02 Feb 2007 09:10:55 +0900 (KST) 
Received: from [61.83.191.48] ([61.83.191.48]) 
          by relay8.kornet.net ([211.48.62.136]) 
          with ESMTP id 2007020209:10:55:546793.17820.8092592
          Fri, 02 Feb 2007 09:10:55 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
In-Reply-To: <Pine.LNX.4.63.0702011703280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38439>

Johannes Schindelin wrote:
> 
> On Mon, 29 Jan 2007, SungHyun Nam wrote:
> 
>> I'm not sure I can believe my system, Windows or CYGWIN.
>> It seems GIT has no problem.
> 
> Are you perchance on a FAT32 system?

No, I have 3 NTFS partitions (C=program, D=work/data, E=temp).
There's no FAT32.

Though I have no FAT32, I even tried the NO_MMAP thing.
And it didn't help.

Thanks,
namsh
