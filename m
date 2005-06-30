From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 2/2] Fix for git-rev-list --merge-order B ^A (A,B share common base)
Date: Thu, 30 Jun 2005 12:47:44 +1000
Message-ID: <2cfc4032050629194744e3edbc@mail.gmail.com>
References: <20050629234533.28709.qmail@blackcubes.dyndns.org>
	 <7v1x6k1z6c.fsf@assigned-by-dhcp.cox.net>
	 <2cfc403205062918336a55e8da@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 04:40:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnoyX-00087t-K8
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 04:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVF3Crq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 22:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVF3Crq
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 22:47:46 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:37009 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262794AbVF3Crp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2005 22:47:45 -0400
Received: by rproxy.gmail.com with SMTP id i8so30817rne
        for <git@vger.kernel.org>; Wed, 29 Jun 2005 19:47:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AaX91fhR5x072l9OR+l5u4CJQ3tCK9/2GtPIX36vjZzLumFW4ZPTlfPYhBzkpQjml21rtb6My2RXaR3iJeL4q7BA7gSg5jezq3nmTuxyAUz0nA4nVAyBXMoXz4eZ+Fcf0NIs7HiM1xDeBjKhHW7vLUZ3arzo4PuFKPvEBW8mvik=
Received: by 10.39.3.14 with SMTP id f14mr255776rni;
        Wed, 29 Jun 2005 19:47:44 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 29 Jun 2005 19:47:44 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <2cfc403205062918336a55e8da@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > Also if you are changing t6001, could you also merge Mark
> > Allen's BSD portability fix while you are at it?
> >
> >     Message-ID: <20050628014337.18986.qmail@web41205.mail.yahoo.com>
> >
> >
> 
> Ok.
> 

Sorry, forgot to do this. However, Mark's patch should still apply as
it is (or will do so with minimal edits), so I'll leave that to Linus'
discretion.

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
