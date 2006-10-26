X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Thu, 26 Oct 2006 17:42:38 +0200
Message-ID: <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com>
References: <200610261641.11239.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 15:42:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zp1AnX7rZc8GXDfsXZPKtYPvmkLoqqQw1HxTyn4+SCYgVRBLJ+ehBS8Ivgr44gnIr3OBVCsJCMwsJkJQlFAkWqsgWlpC29XjCcSsI4/FWEYKrK1+0Z1omTokExVZdw77LmKGwDDrsCswUHH8aWtZEPSxRPgoeTwvh8heOmcxMA0=
In-Reply-To: <200610261641.11239.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30230>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd7NT-0000za-Mg for gcvg-git@gmane.org; Thu, 26 Oct
 2006 17:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423582AbWJZPmk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 11:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423583AbWJZPmk
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 11:42:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:7614 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1423582AbWJZPmk
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 11:42:40 -0400
Received: by wr-out-0506.google.com with SMTP id i7so99108wra for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 08:42:39 -0700 (PDT)
Received: by 10.78.200.3 with SMTP id x3mr2053356huf; Thu, 26 Oct 2006
 08:42:38 -0700 (PDT)
Received: by 10.78.128.2 with HTTP; Thu, 26 Oct 2006 08:42:38 -0700 (PDT)
To: "Andy Parkins" <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

