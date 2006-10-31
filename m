X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] make git-push a bit more verbose
Date: Tue, 31 Oct 2006 23:13:15 +0100
Organization: At home
Message-ID: <ei8hpd$inu$1@sea.gmane.org>
References: <Pine.LNX.4.64.0610311648220.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 31 Oct 2006 22:14:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30601>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf1sB-0000bO-D0 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 23:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946055AbWJaWOQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 17:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946056AbWJaWOQ
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 17:14:16 -0500
Received: from main.gmane.org ([80.91.229.2]:26249 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1946055AbWJaWOP (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 17:14:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gf1rZ-0000PT-H5 for git@vger.kernel.org; Tue, 31 Oct 2006 23:13:41 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 23:13:41 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 31 Oct 2006
 23:13:41 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:

> Currently git-push displays progress status for the local packing of 
> objects to send, but nothing once it starts to push it over the 
> connection.  Having progress status in that later case is especially 
> nice when pushing lots of objects over a slow network link.

Thanks a lot!
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

