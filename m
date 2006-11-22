X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [Patch to DRAFT 2 (2/2)] Branching and merging with git
Date: Wed, 22 Nov 2006 14:36:03 +0100
Message-ID: <45645243.4030400@lsrfire.ath.cx>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net>	<20061120235136.4841.qmail@science.horizon.com> <7vlkm3u4kl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 22 Nov 2006 13:36:25 +0000 (UTC)
Cc: linux@horizon.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <7vlkm3u4kl.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32086>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmsGs-0005rj-Qu for gcvg-git@gmane.org; Wed, 22 Nov
 2006 14:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755865AbWKVNgJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006 08:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbWKVNgJ
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 08:36:09 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de
 ([217.172.187.230]:48273 "EHLO neapel230.server4you.de") by vger.kernel.org
 with ESMTP id S1755865AbWKVNgI (ORCPT <rfc822;git@vger.kernel.org>); Wed, 22
 Nov 2006 08:36:08 -0500
Received: from [10.0.1.3] (p508E413F.dip.t-dialin.net [80.142.65.63]) by
 neapel230.server4you.de (Postfix) with ESMTP id 1441622005; Wed, 22 Nov 2006
 14:36:07 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano schrieb:
> -tools will not let you commit to the branch.
> +tools will not let you commit to the remote branchbranch.

s/branchbranch/branch/

