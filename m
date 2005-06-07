From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add support for --wrt-author, --author and --exclude-author switches to git-rev-list
Date: Wed, 8 Jun 2005 01:58:05 +1000
Message-ID: <2cfc4032050607085861bea2aa@mail.gmail.com>
References: <20050607091523.14051.qmail@blackcubes.dyndns.org>
	 <20050607094947.GC2676@pasky.ji.cz>
	 <2cfc403205060702594da21fb1@mail.gmail.com>
	 <2cfc403205060702596dee7341@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Jun 07 17:57:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfgPW-0000YC-LS
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 17:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVFGP6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 11:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVFGP6S
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 11:58:18 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:44371 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261919AbVFGP6H convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 11:58:07 -0400
Received: by rproxy.gmail.com with SMTP id i8so247454rne
        for <git@vger.kernel.org>; Tue, 07 Jun 2005 08:58:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LHoyIvlEpod6ymN5WFATRKPIvMZLFFeqJTdAZQQ17nNyNSfQt5gB+jZgipcqywLfY2y9mqbZuhRPQ8QYmz1+wUajfngvfD8ntt6U2gG8FnTGKeZc3P4ara8ghVQcXvjxOgXhrPAQxU5OTytTlR3dyTGum2gl5LmRbiIkRJzSUEM=
Received: by 10.38.11.34 with SMTP id 34mr3120204rnk;
        Tue, 07 Jun 2005 08:58:05 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 7 Jun 2005 08:58:05 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc403205060702596dee7341@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> --wrt-author helps to reconstruct the merge-history from the
> perspective of each individual committer.
> 

Correction:

--wrt-author helps to reconstruct the merge-history from the
perspective of each individual author.

jon.
