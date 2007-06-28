From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Avoid perl in t1300-repo-config
Date: Thu, 28 Jun 2007 13:00:26 +0200
Message-ID: <81b0412b0706280400u5c234fb6hd72a431f57ec8975@mail.gmail.com>
References: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com>
	 <7vmyykog4e.fsf@assigned-by-dhcp.pobox.com>
	 <81b0412b0706280041i535efdf0r87e552551b796044@mail.gmail.com>
	 <f5vuv9$f8s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 13:00:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3rjj-0002pp-9F
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 13:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738AbXF1LA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 07:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757641AbXF1LA3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 07:00:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:10397 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbXF1LA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 07:00:29 -0400
Received: by ug-out-1314.google.com with SMTP id j3so550955ugf
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 04:00:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eQ53s6YuGt/wHuBk30xqerZCGT9j0wvkc4tLW3OXzRubMKSQE75t/ami4MsuIDuVFW1MmUShqOZUyCPQZp6Lzhu1jX0zyIjLdFx6nAwk9jupbax8FOaSKk8PUXJTxuJ+Fk/t/x1AvymO0UkIEStyRRQpWopjYgk2wL+X/WvsCLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O6kZwPn1wKSFSbdPos4qj+wtYMqL3TmsCHiKlyGddM7pUGedRFkRdyd8/lMz5+p/3Zzu2sW9B6ucAAVgWSMkcTuMWRoVstzluUQ1bJociJO52mArz338d+0CUH39qFSx+tkfsX54x0df95LCheCP3y0z6/zAD3TwviSdfmHv0sw=
Received: by 10.78.184.2 with SMTP id h2mr822965huf.1183028426873;
        Thu, 28 Jun 2007 04:00:26 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 28 Jun 2007 04:00:26 -0700 (PDT)
In-Reply-To: <f5vuv9$f8s$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51096>

On 6/28/07, Jakub Narebski <jnareb@gmail.com> wrote:
> >> By the way, is it possible for gmail users to avoid attachments
> >> when sending patches in?
> >
> > No. The message text is unpredictably garbled
>
> If by "gmail users" you mean gmail web interface, then probably no.
> No problems with using gmail from email client or from git-send-email
> (the latter after configuring sendmail in my case).

Can't. M$ Exchange plagued
