X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: Unprivileged User
Date: Thu, 30 Nov 2006 10:50:59 +0000 (UTC)
Message-ID: <loom.20061130T115021-789@post.gmane.org>
References: <2b9545a0611292154r4334d1afn1f49bbd3be2c3374@mail.gmail.com> <ekm6si$psp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 10:51:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 7
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 200.213.42.52 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32720>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpjVo-0002zc-0g for gcvg-git@gmane.org; Thu, 30 Nov
 2006 11:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756025AbWK3KvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 05:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757093AbWK3KvZ
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 05:51:25 -0500
Received: from main.gmane.org ([80.91.229.2]:50669 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755620AbWK3KvY (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 05:51:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpjVU-0002uP-M8 for git@vger.kernel.org; Thu, 30 Nov 2006 11:51:11 +0100
Received: from C8D52A34.poa.virtua.com.br ([C8D52A34.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 11:51:08 +0100
Received: from pazu by C8D52A34.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 11:51:08 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb <at> gmail.com> writes:

> Perhaps gitweb should use user.name from the repository instead...

That would make more sense to me.

-- Pazu
