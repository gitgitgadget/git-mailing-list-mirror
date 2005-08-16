From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Tue, 16 Aug 2005 23:29:15 +1200
Message-ID: <46a038f9050816042949c414c7@mail.gmail.com>
References: <46a038f9050814235140877be7@mail.gmail.com>
	 <7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90508150037f128d6@mail.gmail.com>
	 <7vacjj3968.fsf@assigned-by-dhcp.cox.net>
	 <46a038f905081501301bd9a801@mail.gmail.com>
	 <7vr7cv1t89.fsf@assigned-by-dhcp.cox.net>
	 <46a038f9050815020511574e3d@mail.gmail.com>
	 <46a038f9050815042036616b08@mail.gmail.com>
	 <7vll32viy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 13:30:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4zd8-0005Uj-Vq
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 13:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbVHPL3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 07:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbVHPL3Q
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 07:29:16 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:56359 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932639AbVHPL3Q convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 07:29:16 -0400
Received: by rproxy.gmail.com with SMTP id i8so934227rne
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 04:29:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DuUvdkuBytOHHaum93zeZnxQJnb6TqVkmGDrbokl3J95H+8qdgQiKFPkcV4SY71/YdUVSZjHrmv99JklwoqwL2+J0Rair7Bwkhi9VfUY12u9eVHkgcutHZkmvuQfSY4nA0fAUHTT3DetJF0JgGIwsilYeOnH4xcios/wipXGE1s=
Received: by 10.39.2.43 with SMTP id e43mr41430rni;
        Tue, 16 Aug 2005 04:29:15 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 16 Aug 2005 04:29:15 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll32viy5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/16/05, Junio C Hamano <junkio@cox.net> wrote:
> However, the -kk change one is a corrupted patch and does not
> apply.  Your MUA ate leading whitespaces, perhaps.

I stupidly did a forward. Rebased to your current pu branch and sent.
From now on I'll be sending straight from cmdline.
 
> I have already slurped in other two patches to cvsimport in the
> proposed updates branch, so could you kindly proofread them (I
> am no expert on cvs networking protocol issues)

Proofread. I don't claim to have understood 100% but it made sense.
Most importantly, it imported several repos perfectly.

cheers,


martin
