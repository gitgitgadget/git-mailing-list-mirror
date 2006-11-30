X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: v2.6.11 tag in kernel tree
Date: Thu, 30 Nov 2006 14:11:02 -0500
Message-ID: <9e4733910611301111j3bc3b641ge46c5e80b19c469c@mail.gmail.com>
References: <9e4733910611292002o289dc4d1u7bde2d457fa97d73@mail.gmail.com>
	 <Pine.LNX.4.64.0611300758290.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 19:11:39 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qyACl/LhBJip07WWGGIVZR7IrRWC8bMhnXdyez5nukMv59DdkCbgFX8yvzsgsHXHLXd9DeaxztZn1i+bE5Hm9WSBixGpARFo7O6WlRb7eNbO9FQXUQ+I4L5x1YEu5g8FvZcjCoig3Rnt3uDoNFGbNhsqJTp9mpzrCq2JuHhglgg=
In-Reply-To: <Pine.LNX.4.64.0611300758290.3513@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32791>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GprJM-0000Cg-Ut for gcvg-git@gmane.org; Thu, 30 Nov
 2006 20:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031182AbWK3TLG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 14:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967892AbWK3TLF
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 14:11:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.227]:62430 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S967891AbWK3TLD
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 14:11:03 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1399938nze for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 11:11:02 -0800 (PST)
Received: by 10.35.79.3 with SMTP id g3mr6971198pyl.1164913862359; Thu, 30
 Nov 2006 11:11:02 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Thu, 30 Nov 2006 11:11:02 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Thanks for the replies, I got it working. I'm trying to decipher the
changes a vendor made to 2.6.11 when they ported it to an ARM device
and peripherals.

It is the usual situation of releasing a GPL tarball without any
documentation as to what they changed.

-- 
Jon Smirl
