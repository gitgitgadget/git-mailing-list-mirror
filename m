X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to revert changes in working tree?
Date: Wed, 06 Dec 2006 13:52:46 +0100
Organization: At home
Message-ID: <el6eau$vg7$1@sea.gmane.org>
References: <45769417.70601@gmail.com> <81b0412b0612060220n11fb7e19hc6ed202759962bd3@mail.gmail.com> <4576A60A.3060003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:51:40 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33449>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrwEh-0004Rk-4J for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760564AbWLFMuw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760569AbWLFMuw
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:50:52 -0500
Received: from main.gmane.org ([80.91.229.2]:55410 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760564AbWLFMuv
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:50:51 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrwEX-0005h9-FB for git@vger.kernel.org; Wed, 06 Dec 2006 13:50:45 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:50:45 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 13:50:45 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Liu Yubao wrote:

> I will try to run git in debugger, wish I can get the reason.

Or you can try to use GIT_TRACE.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

