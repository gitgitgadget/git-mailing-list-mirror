From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Wed, 8 Jun 2005 21:14:19 +1000
Message-ID: <2cfc40320506080414303d6d7b@mail.gmail.com>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org>
	 <20050607094947.GC2676@pasky.ji.cz>
	 <2cfc403205060702594da21fb1@mail.gmail.com>
	 <20050608085834.GC7916@pasky.ji.cz>
	 <2cfc403205060802315ba2433a@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 13:12:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfySc-0007Qa-Qo
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 13:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVFHLOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 07:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVFHLOc
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 07:14:32 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:24157 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262172AbVFHLOW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 07:14:22 -0400
Received: by rproxy.gmail.com with SMTP id i8so243744rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 04:14:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N2p1oMIBufDz+zpX9YwXWjIQCIEGdnV64kZAHOWTifwh5BpLJzmT24w3dICsT6dd4luBPGye+02EqDDSVTYdsRcr+iEPgH/AWD9NHFSBx0ksskswolonohV/m/6E3fNcrjOhM1AaMGg7p/vy3IVyqDRorDbcCQClq5223emKgAI=
Received: by 10.38.97.66 with SMTP id u66mr3619969rnb;
        Wed, 08 Jun 2005 04:14:19 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 8 Jun 2005 04:14:19 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <2cfc403205060802315ba2433a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pasky,

Hey, I was thinking, instead of stop-at-author, how about we call it
prune-at-author instead?

Regards,

jon.
