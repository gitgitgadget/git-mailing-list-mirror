X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-format-patch little gripe
Date: Fri, 3 Nov 2006 22:22:21 +1300
Message-ID: <46a038f90611030122reecee87ufac5bbaa910ee933@mail.gmail.com>
References: <376237.14965.qm@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 09:22:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=me62o4OHLQsbUDuiH3c5oxtBLFtMBS7hC/9ny1XWvOOvmH6LT544YHH/UL5S2AT5M8fhDOSuyXhop+TB2OUd1Uuppc+Cj6zFintCF2AZ5b6cZd19i9++Vv2YcJMJb83XA3+uST3FWOnR4xd1vEWySLG8ZI7m+WwS70lbHT0W2/Y=
In-Reply-To: <376237.14965.qm@web31805.mail.mud.yahoo.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30803>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfvFr-0003ER-G3 for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751010AbWKCJWY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 04:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbWKCJWY
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:22:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:36041 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1751010AbWKCJWX
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 04:22:23 -0500
Received: by nf-out-0910.google.com with SMTP id b2so1204474nfe for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 01:22:22 -0800 (PST)
Received: by 10.49.27.17 with SMTP id e17mr952580nfj.1162545741988; Fri, 03
 Nov 2006 01:22:21 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Fri, 3 Nov 2006 01:22:21 -0800 (PST)
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

On 11/3/06, Luben Tuikov <ltuikov@yahoo.com> wrote:
> Yep, after more than a year, I simply cannot get used to it...
> http://marc.theaimsgroup.com/?l=git&m=113259043217761&w=2
> And as I've seen, other people brought that up too.

Hi Luben,

reading the thread, it sounds like you have a couple of shells scripts
or aliases that do what you want already ;-)

And for the scenario you mention, where upstream has taken some of
your patches... git-format-patch automatically tries to skip those.
Works well for me at least (ducks).


