From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: remove perl from git-commit.sh
Date: Wed, 12 Jul 2006 13:35:18 +0200
Message-ID: <dbfc82860607120435v5482ce31pdf002f049c51669a@mail.gmail.com>
References: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
	 <dbfc82860607120417m19c0ecefydb4b3f4cf60d646a@mail.gmail.com>
	 <81b0412b0607120423q8c75ecl7d42dfd67f99a549@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 12 13:35:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0d00-00042a-PW
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 13:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWGLLfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 07:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWGLLfU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 07:35:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:22117 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751271AbWGLLfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 07:35:19 -0400
Received: by wr-out-0506.google.com with SMTP id 58so95588wri
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 04:35:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=U8PXTBkIleQ/QlHknTHJkRF46VHgq+1wX4+EWMART5zGmoWqZZsiSrcRqheYldHGK752bHGFOjdCOyLjYH1XFpyt4Kr2onQmWkp670V825ux97E2JmmG7psdKRH8j4HuLGA+CVffmfeZeuNgCuukzVuVPXm8VzRwoaxMn1IDpJ0=
Received: by 10.82.109.13 with SMTP id h13mr59508buc;
        Wed, 12 Jul 2006 04:35:18 -0700 (PDT)
Received: by 10.78.178.20 with HTTP; Wed, 12 Jul 2006 04:35:18 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0607120423q8c75ecl7d42dfd67f99a549@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: cac59b04bbd64607
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23776>

On 7/12/06, Alex Riesen <raa.lkml@gmail.com> wrote:

> On 7/12/06, Nikolai Weibull <now@bitwi.se> wrote:

> > > Otherwise I'd better suggest to add another
> > > quoting style (replacing only \t, \n and backslash)

> > One could always do the quoting with sed, or am I missing something?

> No, but if look closely at this list you'll find a lot of incompatibilities
> in sed too. So the less, the better

Well, that's true, of course, but something as "simple" as what is
needed in this case should be possible.  Anyway, I was just wondering
what the motives were, not questioning them ;-).

  nikolai
