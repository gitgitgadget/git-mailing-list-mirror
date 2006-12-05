X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: latest update to git-svn blows up for me
Date: Tue, 5 Dec 2006 01:13:15 -0800
Message-ID: <20061205091315.GD27236@soma>
References: <20061204181241.GA27342@soma> <86zma3lahj.fsf@blue.stonehenge.com> <20061204195452.GB27342@soma> <86slfvl95j.fsf@blue.stonehenge.com> <20061204200844.GC30316@hand.yhbt.net> <86odqjl8vp.fsf@blue.stonehenge.com> <20061204205126.GA23853@hand.yhbt.net> <20061205040844.GA6826@localdomain> <86slfvj7oi.fsf@blue.stonehenge.com> <86odqjj70y.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 09:13:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <86odqjj70y.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33327>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWMb-0007nX-CI for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968142AbWLEJNS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 04:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968144AbWLEJNS
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:13:18 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43124 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968142AbWLEJNR
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 04:13:17 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 45A7C2DC034; Tue,  5 Dec 2006 01:13:15 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  5 Dec 2006
 01:13:15 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> 
>     no blob information

Can you make Data::Dumper display $fb where it dies with that message?
Thanks.

-- 
