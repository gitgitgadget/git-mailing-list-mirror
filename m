X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Can't fetch 2.6.20-rc1 tag...
Date: Mon, 18 Dec 2006 14:09:25 +0100
Message-ID: <38b2ab8a0612180509t4306fa5fl7dced584e8c53d7@mail.gmail.com>
References: <38b2ab8a0612180356t5c04f5bn29d7be3d0aa40764@mail.gmail.com>
	 <BAYC1-PASMTP1091AB27E446DFAD251A6DAEC90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 23:51:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iB9nM8KhTx0qSh4KqNzqmj+A3RY4mpkiVA4qN7eOuj+xcdoXCrciQR8S3SSKHOMCC87DYGWUz9i7XgU+MX2cgU1UvT2xs1/IVRjZYCVdRTI0g0hGmPZRw/JHcunQEWqq/ifNCoD7d8lk4HPQbvDMhZgG5TG1RHTQBfWKhtIqWWk=
In-Reply-To: <BAYC1-PASMTP1091AB27E446DFAD251A6DAEC90@CEZ.ICE>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34768>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwIFN-000723-Mm for gcvg-git@gmane.org; Mon, 18 Dec
 2006 14:09:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753905AbWLRNJ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 08:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbWLRNJ0
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 08:09:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:8365 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753905AbWLRNJ0 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec
 2006 08:09:26 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1375002wxd for
 <git@vger.kernel.org>; Mon, 18 Dec 2006 05:09:25 -0800 (PST)
Received: by 10.90.93.6 with SMTP id q6mr3580318agb.1166447365432; Mon, 18
 Dec 2006 05:09:25 -0800 (PST)
Received: by 10.90.106.16 with HTTP; Mon, 18 Dec 2006 05:09:25 -0800 (PST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On 12/18/06, Sean <seanlkml@sympatico.ca> wrote:
> You're not doing anything wrong.  There is a problem on one of the
> kernel.org mirrors, it seems to have been that way for a few days.
> If you use "204.152.191.37" instead of git.kernel.org it should work.
>

Yes it does.

thanks for your answer.
-- 
