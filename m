From: Andreas Ericsson <ae@op5.se>
Subject: Re: git integration with monodevelop
Date: Fri, 14 Nov 2008 14:53:55 +0100
Message-ID: <491D82F3.2090807@op5.se>
References: <491AAE6D.8030304@op5.se> <491AF20D.4070600@kde.ru> <491AF768.3010607@op5.se> <491B02FF.2060204@kde.ru> <491BD532.9090200@op5.se> <alpine.DEB.1.00.0811141429040.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Evgeniy Ivanov <powerfox@kde.ru>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 14 14:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0z8m-0002bE-MW
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 14:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbYKNNx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 08:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbYKNNx7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 08:53:59 -0500
Received: from mail.op5.se ([193.201.96.20]:50604 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbYKNNx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 08:53:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6797524B0019;
	Fri, 14 Nov 2008 14:48:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7gyMTztXTJV7; Fri, 14 Nov 2008 14:48:26 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id C1B041B80046;
	Fri, 14 Nov 2008 14:48:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.DEB.1.00.0811141429040.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100975>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 13 Nov 2008, Andreas Ericsson wrote:
> 
>> Evgeniy Ivanov wrote:
>>
>>> But this is the same things Shawn has suggested to my mentor and me at 
>>> the beginning of SoC...
>> Oh? I didn't know libgit2 started as a SoC project.
> 
> It did not.  It started as a request from GitHub, and following 
> discussion, at the GitTogether '08.
> 
> There _was_ a SoC project last year, libgit-thin, but the problem as far 
> as GitHub is concerned was that it was a tear-down approach: it took 
> git.git and tried to make a small library of it, and by this approach was 
> bound to the GPL.
> 

Oh. I was under the impression that libgit2 would also be able to reuse
code from git.git, since there was that huge license thread a couple of
months ago. Did I misinterpret that thread, and everything in libgit2
has to be implemented from scratch?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
