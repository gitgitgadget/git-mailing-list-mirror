X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit-1.5.3
Date: Wed, 15 Nov 2006 16:23:24 +0100
Message-ID: <e5bfff550611150723p691fc480m874cce9ad4d64476@mail.gmail.com>
References: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>
	 <45585749.5030200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 15:23:59 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WzURjAf+pusTjk4y+5uMavypDtNwv6UihNxPCJSKh2PUj+mekVhtG3nZvq0tAOm4JMCb2AVHOmlzO2ktN7CuAWTiQN4kxA0MIQzjtd3ylIStuTcONvV6U1XBZUwEXXin3arTnWb3yko6/GFS2bkCOqUMMLzkwEe1EeUA/CKu8Is=
In-Reply-To: <45585749.5030200@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31445>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkMcA-0006Ys-M4 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 16:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030548AbWKOPX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 10:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWKOPX1
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 10:23:27 -0500
Received: from nz-out-0102.google.com ([64.233.162.206]:2962 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1030548AbWKOPX0
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 10:23:26 -0500
Received: by nz-out-0102.google.com with SMTP id l1so63408nzf for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 07:23:26 -0800 (PST)
Received: by 10.35.51.13 with SMTP id d13mr3495438pyk.1163604204709; Wed, 15
 Nov 2006 07:23:24 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Wed, 15 Nov 2006 07:23:24 -0800 (PST)
To: "Andreas Ericsson" <ae@op5.se>
Sender: git-owner@vger.kernel.org

On 11/13/06, Andreas Ericsson <ae@op5.se> wrote:
> Marco Costalba wrote:
> >
> > Download tarball from http://www.sourceforge.net/projects/qgit
> > or directly from git public repository
> > git://git.kernel.org/pub/scm/qgit/qgit.git
> >
>
> Love the tool, but can't fetch the tag. Did you forget to
>
>         $ git push origin 1.5.3
>

I think I have pushed the new tag, indeed the gitweb interface on
kernel.org/git shows correctly the 1.5.3 tag (and also two new commits
after that).

I've also pulled from kernel.org/git/qgit in a test repository and got
the tag succesfully.

I'm not able to reproduce this, in any case I will push again the tags.

Thanks
