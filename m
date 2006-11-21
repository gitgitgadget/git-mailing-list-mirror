X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Some tips for doing a CVS importer
Date: Wed, 22 Nov 2006 09:40:28 +1300
Message-ID: <46a038f90611211240u4e493f46i2cc46ab780e6c49b@mail.gmail.com>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
	 <87vel9y5x6.wl%cworth@cworth.org>
	 <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com>
	 <20061121063934.GA3332@spearce.org>
	 <20061121200341.GH7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 20:41:14 +0000 (UTC)
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Jon Smirl" <jonsmirl@gmail.com>, "Carl Worth" <cworth@cworth.org>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pLuMGcRxLdC8QWebAeW4LIWSt0nEaAYZ2HwJFkLE4kfGWRLus9aKoF/CLgPsMublOpmIrlxyveF1TQLzXYw8IXz0osTtQhsQUNb2eZ0YCSuPeW0WiKwfacW0Dbtxy3K8xPoYxqo89YNTBR0yehvez5jkoEMMKaq0D0mzyy2MZSg=
In-Reply-To: <20061121200341.GH7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32036>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmcPy-00070R-Mn for gcvg-git@gmane.org; Tue, 21 Nov
 2006 21:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031413AbWKUUkb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 15:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031418AbWKUUkb
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 15:40:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:45036 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1031413AbWKUUka
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 15:40:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so288966nfa for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 12:40:29 -0800 (PST)
Received: by 10.48.235.9 with SMTP id i9mr1440382nfh.1164141628443; Tue, 21
 Nov 2006 12:40:28 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Tue, 21 Nov 2006 12:40:28 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 11/22/06, Petr Baudis <pasky@suse.cz> wrote:
> >   - No GUI.
>
> It has been my impression that Git's situation is far better than in
> case of the other systems (except SVN: TortoiseSVN and RapidSVN). Is
> that not so?

I think GIT is in pretty good shape in all the items mentioned Shawn
lists except the Win32 port.

     Confusing doco? All of them ;-)
     Push/pull terminology confusion -- all of them again.

My only thing is that I continue to teach Cogito instead of GIT
because the index is a great thing for a top-level maintainer of a
large project but it really offers almost next to nothing to a user
who wants to make a commit.

but that hasn't stopped adoption over here...

cheers,



