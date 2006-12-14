X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 21:37:53 +0000
Message-ID: <200612142137.54505.andyparkins@gmail.com>
References: <200612141519.44294.andyparkins@gmail.com> <200612142123.16291.andyparkins@gmail.com> <7virge17yh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 21:40:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=O4ERMm8d6I0OHFNU2/Q+ZwBDidRwMhH7hGRNMzNyhgD8J6JPPlycAueuiTWhMCJjGnsz41wkP55rHWNTe60vZIo60oXjT3TaJm2pvFgQv4JfM4h3t2SuWRi0P3MiroEIeR0QsDb+Ggz32MIeDyZN+9oxSSSCrXvgjYbFRAzqIKo=
User-Agent: KMail/1.9.5
In-Reply-To: <7virge17yh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34409>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuyJk-00040j-8C for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932943AbWLNVkh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932944AbWLNVkh
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:40:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:46505 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932943AbWLNVkg (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 16:40:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so627258uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 13:40:35 -0800 (PST)
Received: by 10.67.117.18 with SMTP id u18mr2184041ugm.1166132435302; Thu, 14
 Dec 2006 13:40:35 -0800 (PST)
Received: from ?192.168.1.48? ( [84.201.153.164]) by mx.google.com with ESMTP
 id b35sm3210754ugd.2006.12.14.13.40.34; Thu, 14 Dec 2006 13:40:34 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006, December 14 21:30, Junio C Hamano wrote:

> I guess that question indicates that the part of my message you
> did not quote was not written cleanly enough.

It was; I'm just stupid.

Let's make the special case "linux-master" and then Linus gets what he wants 
and consistency is restored.

No?  Okay, I give up then. :-)


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
