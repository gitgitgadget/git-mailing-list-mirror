X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Allow subcommand.color and color.subcommand color configuration
Date: Wed, 13 Dec 2006 22:52:50 +0000
Message-ID: <200612132252.51696.andyparkins@gmail.com>
References: <200612130913.28917.andyparkins@gmail.com> <7vodq7e90z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 22:55:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P18ICzHHpnrCrcTzOfwg7xQIYBKt8kRbAj6k3H68cglowZDjQkT5H0f8MFmaBsOdFjR80e29RkdfWvoOhDBQy92bnbPCjYhu0fIaEmolas902XJUfBOIGuBkgrWtJ6fOGjLjYw0pHGyDLwjFNOWSqYpIRzXynNSgX/Kxios3yi8=
User-Agent: KMail/1.9.5
In-Reply-To: <7vodq7e90z.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34247>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gud0i-0005Gw-Ei for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751680AbWLMWze (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 17:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWLMWzd
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:55:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:4560 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751680AbWLMWzd (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 17:55:33 -0500
Received: by ug-out-1314.google.com with SMTP id 44so316322uga for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 14:55:32 -0800 (PST)
Received: by 10.66.232.9 with SMTP id e9mr284769ugh.1166050531703; Wed, 13
 Dec 2006 14:55:31 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id l33sm1267559ugc.2006.12.13.14.55.31; Wed, 13 Dec
 2006 14:55:31 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, December 13 22:16, Junio C Hamano wrote:

> I think doing the same makes sense.  Something like this?

Perfect - yes that is the solution.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
