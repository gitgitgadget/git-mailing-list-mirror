X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH 2/3] git-svn: documentation updates
Date: Wed, 29 Nov 2006 12:35:07 +0000 (UTC)
Message-ID: <loom.20061129T133305-813@post.gmane.org>
References: <1164768702941-git-send-email-normalperson@yhbt.net> <11647687042130-git-send-email-normalperson@yhbt.net> <456D36CE.1060300@midwinter.com> <20061129085419.GB4486@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 12:36:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 10
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.99.93 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-GB; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32638>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpOfS-0003Si-Qf for gcvg-git@gmane.org; Wed, 29 Nov
 2006 13:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967169AbWK2Mfv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 07:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967172AbWK2Mfv
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 07:35:51 -0500
Received: from main.gmane.org ([80.91.229.2]:52370 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S967169AbWK2Mfu (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 07:35:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpOf1-0003Ox-8X for git@vger.kernel.org; Wed, 29 Nov 2006 13:35:36 +0100
Received: from C925635D.poa.virtua.com.br ([C925635D.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 13:35:35 +0100
Received: from pazu by C925635D.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 29 Nov 2006
 13:35:35 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson <at> yhbt.net> writes:

> Also, something that can wrap (git commit && git svn dcommit) into one
> step would be nice.

What I'd like to see is foreign systems integration for git pull/push. If git
had to use git-svn behind the curtains, so be it would be -very- nice if the
user could just use git pull/push.

-- Pazu
