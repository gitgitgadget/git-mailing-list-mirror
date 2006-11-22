X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Add support to git-branch to show local and remote branches
Date: Wed, 22 Nov 2006 08:53:22 +0000
Message-ID: <200611220853.24378.andyparkins@gmail.com>
References: <200611211931.24868.andyparkins@gmail.com> <7vwt5owlhm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 22 Nov 2006 08:53:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FFMhqaU9SZ5RrfwS99d5b4pRmSmy6QbR3aK+wQ9Rj3Fjk0llWXcuDb6J39S6Yp8j2qX7tkJmYVtd7BIl9W3GqRvorFFUaW7HG1b4OZ2S0Em1dXsdM5+NcX3wzR6W4FBRbd2N8jnIXEVCQOGUP2in4k44xUtR8lxuLj2fY2L9Xr8=
User-Agent: KMail/1.9.5
In-Reply-To: <7vwt5owlhm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32070>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmnrK-0000l4-9m for gcvg-git@gmane.org; Wed, 22 Nov
 2006 09:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161970AbWKVIxa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 03:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031346AbWKVIxa
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 03:53:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:25648 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1031238AbWKVIx3
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 03:53:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so96659uga for
 <git@vger.kernel.org>; Wed, 22 Nov 2006 00:53:28 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr2668268ugg.1164185607896; Wed, 22
 Nov 2006 00:53:27 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id q1sm7447477uge.2006.11.22.00.53.27; Wed, 22 Nov 2006 00:53:27 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 21 21:14, Junio C Hamano wrote:

> Thanks.  I'll drop the one in 'pu' and will replace with this
> patch but with style fixes and keeping the documentation updates
> from there.

Sorry; I must remember to write documentation.  I'll be sure to look at the 
style changes and try to adhere to that style in future.

Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
