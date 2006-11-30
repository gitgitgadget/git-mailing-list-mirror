X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 17:12:43 +0100
Message-ID: <456F02FB.6010901@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301255.41733.andyparkins@gmail.com> <456EE3F1.5070101@b-i-t.de> <200611301449.55171.andyparkins@gmail.com> <456F0153.5000107@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 16:13:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <456F0153.5000107@b-i-t.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32766>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoWx-0006B1-4K for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030649AbWK3QMx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967828AbWK3QMw
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:12:52 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:13785 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S1030649AbWK3QMv
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:12:51 -0500
Received: (qmail 24260 invoked by uid 1011); 30 Nov 2006 16:12:50 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(-1.1/5.0):.  Processed in
 0.240852 secs); 30 Nov 2006 16:12:50 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 30 Nov 2006 16:12:50
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id DF3BC25537; Thu, 30 Nov 2006 17:12:44
 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

sf wrote:
...
> A suffix : followed by a path, _followed by a suffix //::_ names the 
> _revision_ at the given path in the tree-ish object named by the part 
> before the colon.

Sorry, that was supposed to read: followed by a suffix //

