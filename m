X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 01:16:19 +0200
Message-ID: <200610290116.19796.jnareb@gmail.com>
References: <200610290100.11731.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 23:15:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UCCZdxuGrAramhrAnfKsqoaN0lmt6592NMO985xOcIpF60X6gsvohWJv3rEiJ2Cawmly2Iz8kPFOP+GRT+WbMq4/b20RdZAhqZk/m7zqF9aCTynlt0BUGFHeBk80h4rWZk6V1ggdvJp1Lwb2vBCVZWsHtAOCANtpp33qGU2V4Dw=
User-Agent: KMail/1.9.3
In-Reply-To: <200610290100.11731.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30403>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdxOq-0003sh-EA for gcvg-git@gmane.org; Sun, 29 Oct
 2006 01:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964912AbWJ1XPc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 19:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWJ1XPc
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 19:15:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:38377 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S964912AbWJ1XPb
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 19:15:31 -0400
Received: by ug-out-1314.google.com with SMTP id 32so923586ugm for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 16:15:30 -0700 (PDT)
Received: by 10.66.243.4 with SMTP id q4mr1864619ugh; Sat, 28 Oct 2006
 16:15:30 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 24sm1232668ugf.2006.10.28.16.15.30; Sat, 28 Oct
 2006 16:15:30 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

By the way, one of the reasons for change is that current view is ill 
prepared for "combined diff" format I'd like to add later.

P.S. This affects of course both commitdiff and blobdiff views.
-- 
Jakub Narebski
