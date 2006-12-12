X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC/PATCH] runstatus: restructure visual appearance
Date: Tue, 12 Dec 2006 12:30:15 +0100
Message-ID: <8c5c35580612120330n36bcdd00p57b2a7cd1d6c801@mail.gmail.com>
References: <11650882251452-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 11:30:31 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gi70q6/CI7OmUvrWTcg2aXR+l1yS3I5U4ZqRg+oRHlO4ZLU/CIAxMA1/tTeeWayBeBoYCMqFLDPhLt2R+YWLcrAsQDbnRo/EpWWJkYs8cbmWDHhKTlmu9SY+ZL2S2C3AvCi7LNvUz+wm+0+/xsogZbvhCfILMsxFAJXbEXpScCk=
In-Reply-To: <11650882251452-git-send-email-hjemli@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34082>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu5q1-0000hZ-Eb for gcvg-git@gmane.org; Tue, 12 Dec
 2006 12:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751229AbWLLLaS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 06:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWLLLaS
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 06:30:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:11594 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751229AbWLLLaR (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 06:30:17 -0500
Received: by nf-out-0910.google.com with SMTP id o25so211760nfa for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 03:30:15 -0800 (PST)
Received: by 10.82.120.14 with SMTP id s14mr1063885buc.1165923015135; Tue, 12
 Dec 2006 03:30:15 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Tue, 12 Dec 2006 03:30:15 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 12/2/06, Lars Hjemli <hjemli@gmail.com> wrote:
> This is a rather subjective 'improvement', but I think it makes the commit
> message easier to comprehend and I hope that goes for both new and
> experienced users.

Just wondering if this patch got dropped or simply overlooked...

If dropped, sorry for the noise

-- 
