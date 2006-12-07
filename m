X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Topic descriptions
Date: Thu, 7 Dec 2006 08:37:13 +0000
Message-ID: <200612070837.16412.andyparkins@gmail.com>
References: <200612062153.30639.andyparkins@gmail.com> <7v4ps8y7un.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 08:40:24 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bfNVmR5dEhlxR80XGvW80TZ1wEw/Kp8MsN4jMsJ+hjeX/kC1DsIjPZoF3FS1pi7q9+IJyDQfcVlzOMGOAHYPFtkB5kgh88pFV058JPbRC4lPJQposSI0VL5sPQMmoIkV0IRP3nK69JkIdGl94dI2U8BDKs+XGiS04rObA+LZwUg=
User-Agent: KMail/1.9.5
In-Reply-To: <7v4ps8y7un.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33560>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsEng-0002gy-VK for gcvg-git@gmane.org; Thu, 07 Dec
 2006 09:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031856AbWLGIkL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 03:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031857AbWLGIkL
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 03:40:11 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:63696 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1031856AbWLGIkI (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 03:40:08 -0500
Received: by nz-out-0102.google.com with SMTP id s1so293373nze for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 00:40:08 -0800 (PST)
Received: by 10.65.193.16 with SMTP id v16mr3141026qbp.1165480807656; Thu, 07
 Dec 2006 00:40:07 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id c6sm454491qbc.2006.12.07.00.40.05; Thu, 07 Dec
 2006 00:40:06 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, December 06 22:31, Junio C Hamano wrote:

> I am unlikely to use such a thing for the "What's in" message,
> though.  The part that talks about "what the current status is"
> is much easier to write when I need to talk about "the current";
> otherwise I'd be forced to remember to think if I need to update
> the information, every time I touch topic branches.

It wasn't so much the what's current - as you say that would be fairly 
ridiculous as it's so fluid.  It was more a description of the topic.  I've 
got tonnes of branches where I have quickly thought of an idea and started 
work on it, only to get bored and move on.  Describing a topic in such a 
short space as "ap/short-name" is hard.

The actual place it's stored isn't really relevant, more that I could see a 
use for it.  If it's going in the config I suppose all it needs is a 
magic "and so it shall be" hand wave.  It doesn't require any new code does 
it?


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
