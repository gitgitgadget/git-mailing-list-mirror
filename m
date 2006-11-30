X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Getting CVS and Git to play nicely in the same box
Date: Thu, 30 Nov 2006 14:08:55 +0100
Organization: At home
Message-ID: <ekml1n$ask$1@sea.gmane.org>
References: <1164890354.21950.92.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 13:07:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 11
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32739>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpldT-0005ql-JH for gcvg-git@gmane.org; Thu, 30 Nov
 2006 14:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936379AbWK3NH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 08:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936380AbWK3NH2
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 08:07:28 -0500
Received: from main.gmane.org ([80.91.229.2]:4043 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936379AbWK3NH1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 08:07:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpldH-0005nm-HC for git@vger.kernel.org; Thu, 30 Nov 2006 14:07:19 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 14:07:19 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 14:07:19 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alex Bennee wrote:

> Has anyone successfully set up such a working environment? Can anyone
> offer any tips on how to make it all work nicely?

Why not use git-cvsserver? Or port git-svn to CVS (or use Tailor)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

