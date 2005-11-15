From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: A case for tailor
Date: Wed, 16 Nov 2005 09:59:17 +1300
Message-ID: <46a038f90511151259l51d13181j670274e123d7610f@mail.gmail.com>
References: <Pine.LNX.4.63.0511151931001.1157@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 22:03:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec7tj-0008PI-LG
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 21:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKOU7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 15:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVKOU7V
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 15:59:21 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:49569 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750738AbVKOU7U convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 15:59:20 -0500
Received: by wproxy.gmail.com with SMTP id i2so1478599wra
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 12:59:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bmTWVeS2loPVq2LhzEEjGVAGjZnOGCSNmEIY7AETwb3DZzTWoeS/9oXkIxTZQzGO6IdJjlhtlOI7Q850WJz0C0USn5DD5TTEyrz1WAx8clY07ygH6acmDzfsaRtkdDyhTLJPT34UjivCjPCWP6/it3rniNogO2w7EpPagvsb0NQ=
Received: by 10.65.218.2 with SMTP id v2mr7566031qbq;
        Tue, 15 Nov 2005 12:59:17 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Tue, 15 Nov 2005 12:59:17 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511151931001.1157@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11939>

On 11/16/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Just wanted to let people know...

I've checked out tailor a while ago, and it seems a quite capable
tool. Even bounced a few emails with the author, because I thought
that we could perhaps deprecate our imports scripts. It _is_ good, and
seems to have a cool community around it.

The short of it is that tailor won't do branches. So for trivial
single-line-of-development projects, you're fine with it, probably
even happier than with our import scripts.  Sadly, none of the
projects I've worked in the last 6 years fall into that category ;-)

cheers,


martin
