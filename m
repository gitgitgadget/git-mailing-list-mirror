From: Ingo Molnar <mingo@elte.hu>
Subject: Re: gitk-1.0 released
Date: Thu, 19 May 2005 15:30:55 +0200
Message-ID: <20050519133055.GA8076@elte.hu>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com> <20050519132411.GA29111@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 15:32:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYl6a-0003D6-CK
	for gcvg-git@gmane.org; Thu, 19 May 2005 15:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVESNbK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 09:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbVESNbK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 09:31:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3730 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262493AbVESNbG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 09:31:06 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 723C9322FB7;
	Thu, 19 May 2005 15:29:34 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 25BD21FC2; Thu, 19 May 2005 15:31:00 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <20050519132411.GA29111@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> - the ability to copy & paste from all the windows would be nice. (e.g. 
>   in the bugreport above i had to type down the "Octopus merge .." text 
>   instead of pasting it from gitk)

scrap this one - the patch view window allows copy & paste, and the name 
of the patch is included there too.

	Ingo
