X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: latest update to git-svn blows up for me
Date: Tue, 5 Dec 2006 08:47:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612050846370.3542@woody.osdl.org>
References: <863b7wnwcw.fsf@blue.stonehenge.com> <20061204070021.GG1369@localdomain>
 <86hcwbnb0o.fsf@blue.stonehenge.com> <20061204181241.GA27342@soma>
 <86zma3lahj.fsf@blue.stonehenge.com> <20061204195452.GB27342@soma>
 <86slfvl95j.fsf@blue.stonehenge.com> <20061204200844.GC30316@hand.yhbt.net>
 <86odqjl8vp.fsf@blue.stonehenge.com> <20061204205126.GA23853@hand.yhbt.net>
 <20061205040844.GA6826@localdomain> <86slfvj7oi.fsf@blue.stonehenge.com>
 <86odqjj70y.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 16:48:44 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86odqjj70y.fsf@blue.stonehenge.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33355>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrdT8-0004Vj-BT for gcvg-git@gmane.org; Tue, 05 Dec
 2006 17:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968440AbWLEQsF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 11:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968448AbWLEQsF
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 11:48:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47173 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968450AbWLEQsB
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 11:48:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB5GlxID009113
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 5
 Dec 2006 08:47:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB5GlwTj003499; Tue, 5 Dec
 2006 08:47:59 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org



On Mon, 4 Dec 2006, Randal L. Schwartz wrote:
> 
> It just hates me, perhaps.

This may be a great moment in time.

We may have reached the point where git is sentient, and passed the 
Turing test without us even realizing.

Please, somebody tell Sarah Connor.

