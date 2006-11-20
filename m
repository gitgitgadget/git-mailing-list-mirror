X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 12:17:37 +0100
Message-ID: <200611201117.39244.andyparkins@gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com> <200611201023.54146.andyparkins@gmail.com> <7vd57i4cij.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 11:18:22 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FmLnA/VOlCEIQTI3MLFHAoPV/h/eCOWrgM+YiTTiSHi48ULOPlJm1JqK8r/KG//b4AktVMM7JZYtZRQJUsefeNrMQToWmWFUzIkgpfYRL9NMnf1mCM/tUg2zOfJZZGGfMhywUs1YUUK38c+SY5P1SHfGS0DCsiP+MHTt/4Y/3UA=
User-Agent: KMail/1.9.5
In-Reply-To: <7vd57i4cij.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31905>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm7AJ-0001rk-QH for gcvg-git@gmane.org; Mon, 20 Nov
 2006 12:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756724AbWKTLRq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 06:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755909AbWKTLRp
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 06:17:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:30485 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1756806AbWKTLRo
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 06:17:44 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1143958ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 03:17:43 -0800 (PST)
Received: by 10.67.91.6 with SMTP id t6mr7654828ugl.1164021462568; Mon, 20
 Nov 2006 03:17:42 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id h1sm7519688ugf.2006.11.20.03.17.41; Mon, 20 Nov 2006 03:17:42 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006 November 20 10:51, Junio C Hamano wrote:

> I think Alex (Riesen) is saying "you (Alex Litvinov) were
> wondering why you do not see the commit log message but only the
> first line. That is because you are using --pretty=oneline.
> Lose it, then you would get what you want because giving the log
> message _is_ the default".

You're right.  Apologies to Alex for my misunderstanding.

-- 
Dr Andy Parkins, M Eng (hons), MIEE
