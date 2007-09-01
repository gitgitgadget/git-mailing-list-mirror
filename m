From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Sat, 1 Sep 2007 19:54:23 +0200
Message-ID: <200709011954.23771.jnareb@gmail.com>
References: <20070831000149.GK1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Sep 02 10:33:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRktk-00065c-He
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 10:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbXIBIdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 04:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbXIBIdc
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 04:33:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:32577 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbXIBIdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 04:33:31 -0400
Received: by nf-out-0910.google.com with SMTP id f5so992441nfh
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 01:33:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=awiipFiKGsxlIHmDjYrCYaDlPTK3zm9Y0BCsMEl5xUEOaGFZ7ZY53zQ5amLVRwlrow53aUHpxKZt0ATtb2x7gJg51rFxGoQ6/7YgEUTanmSQn9jvk6E/jXB5fhWHoMfPoYuLD1kMVFLtyiQromooOj1PKrCQDZRIFqtvArfWxGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fAoG7hWy78X9ZsET0flIXSr2dIL8WePLjibgRoPQxuL2tmQH8GF2ELLQjB/EqLppt3PhbDGVq8J59PIhFdyIuUZ5tjOPoFNt0ufFHVy4hUsFyz4a1noviISIiOQzWXeIZ6TPfRWT+8rOrBHgxTrpNRqMJoET1yAtD89+eCTXcY8=
Received: by 10.86.77.5 with SMTP id z5mr2347369fga.1188722009532;
        Sun, 02 Sep 2007 01:33:29 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 28sm3215742fkx.2007.09.02.01.33.24
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Sep 2007 01:33:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070831000149.GK1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57306>

On Friday, 31 August 2007, Petr Baudis wrote:

>   Please feel encouraged to make random forks for your development
> efforts, or push your random patches (preferrably just bugfixes,
> something possibly controversial should be kept in safe containment
> like a fork or separate branch) to the mob branch.

What are the rules of pushing to the mob branch? Fetch, rebase, push?
Does mob branch allows non fast-forward pushes?

-- 
Jakub Narebski
Poland
