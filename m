X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: Re: GIT - releases workflow
Date: Wed, 13 Dec 2006 06:39:22 -0600
Message-ID: <89b129c60612130439m452b315x2278456396a248a5@mail.gmail.com>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>
	 <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1166001019.19098.4.camel@localhost.localdomain>
	 <89b129c60612130434q18c69c7bxd96b7db0c423d8ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 12:39:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kRZPHTMF9EvezZN0oGsDg/2an8OF4E9IMYf4xPFCuC698E41IM9d+bLBgvzK7TinqsiE3yH+7gVAZY6Ol9NcKUM6PZkbOGGGTTs9zDzdbA/J2Q994rxpY3TXZsQ+4stt3l9S9n3WufPFYJOEGpxua/W1gZws42yvXJAoqihTa3s=
In-Reply-To: <89b129c60612130434q18c69c7bxd96b7db0c423d8ea@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34216>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuTOR-00059Q-37 for gcvg-git@gmane.org; Wed, 13 Dec
 2006 13:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964917AbWLMMjY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 07:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWLMMjY
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 07:39:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:50613 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S964897AbWLMMjX (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 07:39:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so158473uga for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 04:39:22 -0800 (PST)
Received: by 10.78.138.6 with SMTP id l6mr581620hud.1166013562074; Wed, 13
 Dec 2006 04:39:22 -0800 (PST)
Received: by 10.78.179.10 with HTTP; Wed, 13 Dec 2006 04:39:21 -0800 (PST)
To: "Matthias Kestenholz" <lists@spinlock.ch>
Sender: git-owner@vger.kernel.org

Hi,

On 12/13/06, Sean Kelley <sean.v.kelley@gmail.com> wrote:
> Hi,
>
> On 12/13/06, Matthias Kestenholz <lists@spinlock.ch> wrote:
> >
> How do I push that tag that I created to the maint/v0.1 branch on the
> remote repository?

Never mind, I answered my own question.  Sorry for asking without
doing my research first.

   git push --tags origin

Thanks,

Sean
>
> Thanks,
>
> Sean
>
>
> >
> > I need a full branch, because I need the ability to do bugfixes for the
> > already-released version.
> >
> > Matthias
> >
> >
>
>
> --
> Sean Kelley
>


-- 
