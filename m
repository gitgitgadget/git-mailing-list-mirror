From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: MinGW merge plans, was Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 15:13:54 +0200
Message-ID: <46D81412.6060407@eudaptics.com>
References: <20070814164453.400b9c55@localhost> <46D7D0F7.1050302@trolltech.com> <46D7D284.30004@telecom.at> <46D7D48D.6000503@trolltech.com> <46D7D60C.8090608@telecom.at> <46D7D8A4.1060800@trolltech.com> <Pine.LNX.4.64.0708311123140.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 15:14:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR6Kr-0007f4-9o
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 15:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194AbXHaNOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 09:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758136AbXHaNOo
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 09:14:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11271 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757860AbXHaNOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 09:14:43 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IR6Kf-0007qS-5Z; Fri, 31 Aug 2007 15:14:42 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 827BA4E4; Fri, 31 Aug 2007 15:14:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0708311123140.28586@racer.site>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.366, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57168>

[I fscked up my email address in my news reader setup. This mail is sent 
from a correct one. Sorry to all who might have received bounces.]

Johannes Schindelin schrieb:
> Hi,
> 
> On Fri, 31 Aug 2007, Marius Storm-Olsen wrote:
> 
>> We really need to streamline the patches needed for MinGW, and get
>> those merged into upstream when 1.5.3 is released.
> 
> Okay, with 1.5.3 just about to break free, I think we can think about
> what to do to flood the mailing list with MinGW compatibility
> patches.

Thanks for summarizing the changes and things to do. I'll respond to
this with more details later this evening, but only to the msysgit list.
(Interested parties are encouraged to join the list - see
http://groups.google.com/group/msysgit).

I've started to rearrange patches and separate out stuff that is not
MinGW specific, but this effort has stalled. I'm waiting for a new
notebook to arrive so that I can continue it during off-work hours.

-- Hannes
