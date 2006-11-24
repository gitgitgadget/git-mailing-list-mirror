X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/5] Shallow clone fixes
Date: Fri, 24 Nov 2006 16:43:47 +0100
Organization: At home
Message-ID: <ek73sd$v0p$1@sea.gmane.org>
References: <8764d4vqno.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 24 Nov 2006 15:42:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32228>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GndCN-0001SD-SS for gcvg-git@gmane.org; Fri, 24 Nov
 2006 16:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934951AbWKXPml (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 10:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934954AbWKXPml
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 10:42:41 -0500
Received: from main.gmane.org ([80.91.229.2]:44452 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934951AbWKXPmk (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 10:42:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GndC5-0001Ne-9s for git@vger.kernel.org; Fri, 24 Nov 2006 16:42:25 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 16:42:25 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 16:42:25 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alexandre Julliard wrote:

> This series fixes a number of small problems in the shallow clone
> support in pu. After that it seems to work fairly well for me.

Could you make the rest of patches in series be reply to (directly or
indirectly) to the introductory message? Thanks in advance.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

