X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git-cvsimport feature request
Date: Fri, 15 Dec 2006 22:06:58 +0700
Message-ID: <fcaeb9bf0612150706g41a07a9fg3c268ef1893ccd27@mail.gmail.com>
References: <fcaeb9bf0612120442v4cd03a5fq44625fafed4217b7@mail.gmail.com>
	 <Pine.LNX.4.63.0612121535290.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0612121334t454ec67av2c319382d1f61cce@mail.gmail.com>
	 <Pine.LNX.4.63.0612122305060.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 15:07:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fHwOMQZF//qTks1qpH7/tdIyM1VpxK2Z5jSE2fpxpWure0CpKNM588WHs/2AJAzVn4gEJ7IGf1eai9aPRtjKaQ9m5nqpI1+5+7d/YJAuLUFchoC9QR1oE3Fnn5XzUfdojxa+tiVz3OAxupd01Xxv/U2IZ9NsRFqO2//Fd4xPwsE=
In-Reply-To: <Pine.LNX.4.63.0612122305060.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34512>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEei-0006YK-KD for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752710AbWLOPHV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbWLOPHV
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:07:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:65356 "EHLO
 wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752710AbWLOPHU (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 10:07:20 -0500
Received: by wr-out-0506.google.com with SMTP id i7so635967wra for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 07:07:19 -0800 (PST)
Received: by 10.49.55.13 with SMTP id h13mr2668415nfk.1166195219224; Fri, 15
 Dec 2006 07:06:59 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Fri, 15 Dec 2006 07:06:58 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On 12/13/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On 12/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > It could be done easily, but it is almost as easy to edit the command line
> > > to substitute "git " with "git repo-config alias.cvsup '" (note the
> > > single apostrophe at the end) and append and apostrophe at the end of the
> > > line.
> >
> > Thanks. I know that (and am doing that). Just think that it may be
> > more convenient typing the command once.
>
> Something like this?

It works great. Thanks.
-- 
