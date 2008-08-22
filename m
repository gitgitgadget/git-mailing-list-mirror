From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Merging repositories and their histories
Date: Fri, 22 Aug 2008 14:19:14 +0200
Message-ID: <81b0412b0808220519p7ad1c994y405ddf33ade12896@mail.gmail.com>
References: <19035412.post@talk.nabble.com> <48ADE2A6.2020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Peter Waller" <peter.waller@gmail.com>, git@vger.kernel.org
To: "Marcus Griep" <neoeinstein@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 14:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWVd2-000823-Qk
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 14:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbYHVMTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 08:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbYHVMTR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 08:19:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:33505 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbYHVMTP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 08:19:15 -0400
Received: by wa-out-1112.google.com with SMTP id j37so132941waf.23
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Cii3QrKTxE1CsRhrkmoqv8sG3+nrS3gHGeJqgBBFaWM=;
        b=V0iYBxgSVoyehxSfwY8gdmgG0ujGeo72xnVR0uHx/sDmsUl8Wbix5R8LyZ17YVkggv
         XXlFAozcTOYlczIWtnhE5/ZCy5GFR+h1CKbTJOdGCTwFoI3lZdsFkWdhJZDqpa2D1nBq
         sqPChDodjCz8jM46y9RER5qChELG4JCi48yxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iJwPuI24SoKzN5CNCTywABBa+Kegwl12dF69tRhtuQuBzqxDuzee4O48eLO/F6PVhl
         K6ilV0rw8YCa8HNwn62C/7VZQL/1bJ6Jr/ZbKtiMeUmYJfGw9+gphrh8qqdbIMVLYQC1
         Nx3doZWg4Mitwjtzy6vO03sUoqmHU9OmZQ05Q=
Received: by 10.115.76.5 with SMTP id d5mr827802wal.191.1219407554575;
        Fri, 22 Aug 2008 05:19:14 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Fri, 22 Aug 2008 05:19:14 -0700 (PDT)
In-Reply-To: <48ADE2A6.2020407@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93286>

2008/8/21 Marcus Griep <neoeinstein@gmail.com>:
>> 2008/8/18 Alex Riesen <raa.lkml@gmail.com>:
>> > > Peter Waller, Mon, Aug 18, 2008 20:15:52 +0200:
>> >> >> 2008/8/18 Alex Riesen <raa.lkml@gmail.com>
>> >> >>
>> >>> >> > Peter Waller, Mon, Aug 18, 2008 18:46:14 +0200:
>> >>>> >> > >
>> >>>> >> > > (The same thing as above)
>
> Did it actually not work?
>

Why not?
