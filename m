From: Jeff Rose <rosejn@gmail.com>
Subject: abbreviated commands
Date: Sun, 25 Feb 2007 18:43:07 +0100
Message-ID: <45E1CAAB.3030203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 25 18:43:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLNPY-0000oH-43
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbXBYRnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbXBYRnN
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:43:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:37527 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965043AbXBYRnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:43:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so638337uga
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 09:43:10 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=dwsiPq0ml9/EnwDNqQVLHhSgM/EoI7bBVztBBFmHs1y56WdA0VRz9UM130auW/F1hSJxLGO9P9WoyqJWuwY9QUpdzjPSkIJfh5y3a+HiPxmRGYt0U1GZ/MkkRH+OIgjqhDV6Hiwvtyj4kgUxxP8hUfuKziCnXWnFu7matpQYkxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HLD41AVRKGGAb6w7UVmj8YpUidbs2CycgMcHT4zMod+s6z+lbZiHVSlAU/YIjrvxCcNgjm/n+T1EjVjntPRoEoP9uxy5ZjlQu+gnKFbeVvR8w8O3g/o0cr6TUXzOXqsfvgKUuqnWnrm2I8og1Jvg20u3SwrgdKyIxm1+9QPT/Ig=
Received: by 10.66.243.4 with SMTP id q4mr5205803ugh.1172425390234;
        Sun, 25 Feb 2007 09:43:10 -0800 (PST)
Received: from ?192.168.70.25? ( [195.176.178.209])
        by mx.google.com with ESMTP id k30sm4775713ugc.2007.02.25.09.43.09;
        Sun, 25 Feb 2007 09:43:09 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40561>

Has there been discussion of adding abbreviated command names to git? 
It would be nice to be able to type the standard abbreviations used by 
many vcs, for example:

ci -> commit
co -> checkout

I searched the mailing list archives but didn't see anything so I 
figured I'd ask.  It would be nice.  Also allowing the shortest uniquely 
  matching command string rather than having to type the whole thing 
would be nice.  (I know, if you do git-foo<tab> it would be the same 
thing, but if the goal is to have git <command> be the standard usage 
these things would be great.)

Thanks for the great system.

-Jeff
