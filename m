From: Tupshin Harper <tupshin@tupshin.com>
Subject: Re: The criss-cross merge case
Date: Wed, 27 Apr 2005 17:43:00 -0700
Message-ID: <42703194.80409@tupshin.com>
References: <Pine.LNX.4.21.0504271854240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bram Cohen <bram@bitconjurer.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:39:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQx3F-0000is-6j
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVD1AoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVD1AoI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:44:08 -0400
Received: from adsl-69-233-54-142.dsl.pltn13.pacbell.net ([69.233.54.142]:36362
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S262130AbVD1AoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 20:44:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by bastard.smallmerchant.com (Postfix) with ESMTP id 221A43A0172;
	Wed, 27 Apr 2005 17:49:19 -0700 (PDT)
Received: from bastard.smallmerchant.com ([127.0.0.1])
	by localhost (mail.smallmerchant.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28254-02-5; Wed, 27 Apr 2005 17:49:01 -0700 (PDT)
Received: from [172.16.1.197] (unknown [172.16.1.197])
	by bastard.smallmerchant.com (Postfix) with ESMTP id 8049F3A016C;
	Wed, 27 Apr 2005 17:49:01 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504271854240.30848-100000@iabervon.org>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at smallmerchant.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:

>I've been looking at Darcs (which seems to have a good method, although I
>think the underlying diff isn't great), and Codeville still doesn't have
>any documentation. Arch's method is strictly weaker than 3-way merge, and
>generates more rejects (not even conflicts) in my experience than even
>CVS. 
>
>	-Daniel
>  
>
Can you clarify what you mean by darcs' underlying diff not being that
great? It seems to function pretty much identically to gnu diff. In what
way would you want the underlying diff to be improved?

-Tupshin
