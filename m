X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git and Mozilla
Date: Tue, 28 Nov 2006 09:13:06 +0000
Message-ID: <200611280913.07820.andyparkins@gmail.com>
References: <9e4733910611272247y7ef8be0fh2f1436d43a57280@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 09:13:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AicQ7j7ffOn9CuUg/AbtOQJcwN/NOgRfKbYJzg5Ug4WDsULoPpJKiOND/KXMZm0cu+xt1jLPifN0zzii2Hzc5yIV6xlHHPDu6x+OnBPI32saqKcPV9Cetz6+wKsfLwxKxHsdqEYrPrEKjUTFn/tpg4ori5akujF2q4O+GKUdq80=
User-Agent: KMail/1.9.5
In-Reply-To: <9e4733910611272247y7ef8be0fh2f1436d43a57280@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32498>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goz1h-0007tV-Ha for gcvg-git@gmane.org; Tue, 28 Nov
 2006 10:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935713AbWK1JNO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 04:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935741AbWK1JNO
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 04:13:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:40911 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935713AbWK1JNO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 04:13:14 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1415557uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 01:13:12 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr1186638ugh.1164705192279; Tue, 28
 Nov 2006 01:13:12 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id e1sm20139029ugf.2006.11.28.01.13.11; Tue, 28 Nov 2006 01:13:11 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 28 06:47, Jon Smirl wrote:
> It looks like git is out of the race for hosting the Mozilla repository.
> It's going to be Bazaar or Mercurial.

This is probably a good thing; Bazaar and Mercurial are both more similar in 
model to git than SVN; so conversion between them and git will be far easier.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
