X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 23:07:51 +0100
Message-ID: <200611302307.52115.Josef.Weidendorfer@gmx.de>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net> <eknhjr$nce$1@sea.gmane.org> <878xhsty3t.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 22:08:28 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <878xhsty3t.wl%cworth@cworth.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32809>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpu4i-00014V-SK for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031533AbWK3WHz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031535AbWK3WHz
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:07:55 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:12981 "EHLO
 mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S1031533AbWK3WHy (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006
 17:07:54 -0500
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de
 [131.159.35.49]) by mail.in.tum.de (Postfix) with ESMTP id 303212818; Thu, 30
 Nov 2006 23:07:53 +0100 (MET)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On Thursday 30 November 2006 22:37, Carl Worth wrote:
> So I'd vote for "resolve" along with something else for the
> mark-as-edited case. Maybe "refresh"? That's the best I've thought of
> so far. Anyone else have a better suggestion?

git stage

