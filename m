X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git bug? + question
Date: Fri, 03 Nov 2006 18:13:33 +0100
Organization: At home
Message-ID: <eiftb1$ild$1@sea.gmane.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net> <20061103094655.GA16721@diana.vm.bytemark.co.uk> <200611031815.49553.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 3 Nov 2006 17:17:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 11
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30868>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg2eW-0004A2-Qc for gcvg-git@gmane.org; Fri, 03 Nov
 2006 18:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753394AbWKCRQV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 12:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbWKCRQV
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 12:16:21 -0500
Received: from main.gmane.org ([80.91.229.2]:57289 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1753394AbWKCRQU (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 12:16:20 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gg2cy-0003jA-3X for git@vger.kernel.org; Fri, 03 Nov 2006 18:14:48 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 18:14:48 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 03 Nov 2006
 18:14:48 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josef Weidendorfer wrote:

> Other option: Introduce "fetchonly" line which ignores the original
> fetch lines in the remote section.

I like this.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

