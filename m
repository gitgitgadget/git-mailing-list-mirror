X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 11:59:47 +0100
Message-ID: <200610291159.48171.jnareb@gmail.com>
References: <200610290100.11731.jnareb@gmail.com> <200610290116.19796.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 11:00:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LvZHwL7BN2SFBmjIWxRXvgdaxEarsIazcsz/BbXg1qoqA8OTmWiXMwza5UlSoACm6Rnl7OGAj4YvSUtv47xuWKXmyVmsO0f15Xrbn/ZngjgoaADSmCJOtxwcrWEMJlkcHFpBCZ2VpUgALI0+GTbvhL5C5KAifVBzr9qTLtxcagY=
User-Agent: KMail/1.9.3
In-Reply-To: <200610290116.19796.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30426>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge8Oe-0004Tb-0U for gcvg-git@gmane.org; Sun, 29 Oct
 2006 12:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932182AbWJ2K7v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 05:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWJ2K7v
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 05:59:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:57908 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932182AbWJ2K7v
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 05:59:51 -0500
Received: by ug-out-1314.google.com with SMTP id 32so963277ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 02:59:50 -0800 (PST)
Received: by 10.66.220.17 with SMTP id s17mr2408212ugg; Sun, 29 Oct 2006
 02:59:49 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id e34sm1806067ugd.2006.10.29.02.59.49; Sun, 29 Oct
 2006 02:59:49 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I had to resend the patch due to "DOT info" being on list of banned 
words...

-- 
Jakub Narebski
