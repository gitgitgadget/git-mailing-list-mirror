X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deleting binary file
Date: Thu, 09 Nov 2006 12:10:12 +0100
Organization: At home
Message-ID: <eiv28t$9l4$1@sea.gmane.org>
References: <1d592d70611090147p6f10f921s740e3cc19cb67c09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 9 Nov 2006 11:10:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 10
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31195>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi7nD-0003BQ-8H for gcvg-git@gmane.org; Thu, 09 Nov
 2006 12:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932769AbWKILJb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 06:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbWKILJb
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 06:09:31 -0500
Received: from main.gmane.org ([80.91.229.2]:61633 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932769AbWKILJa (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 06:09:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gi7mh-00036a-NN for git@vger.kernel.org; Thu, 09 Nov 2006 12:09:27 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 12:09:27 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 09 Nov 2006
 12:09:27 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Kirill Shutemov wrote:

>$ git-applymbox 0001-test.txt

Does using "git am --binary 0001-test.txt" help?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

