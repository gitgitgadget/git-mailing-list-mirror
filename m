X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not
 so large)?
Date: Tue, 21 Nov 2006 11:01:01 -0600
Organization: Freescale
Message-ID: <456330CD.9080503@freescale.com>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net> <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org> <45632EC6.5030902@freescale.com> <20061121165656.GC22006@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 17:02:54 +0000 (UTC)
Cc: Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
In-Reply-To: <20061121165656.GC22006@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32005>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmZ14-0006Nr-9y for gcvg-git@gmane.org; Tue, 21 Nov
 2006 18:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031220AbWKURBR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 12:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031214AbWKURBO
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 12:01:14 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:57801 "EHLO
 de01egw02.freescale.net") by vger.kernel.org with ESMTP id S1031096AbWKURBM
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 12:01:12 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net
 [10.208.0.31]) by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
 kALHF913018137; Tue, 21 Nov 2006 10:15:09 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
 by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kALH11wW011908; Tue,
 21 Nov 2006 11:01:01 -0600 (CST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:
> Timur Tabi <timur@freescale.com> wrote:
>>> Shallow clone is a development feature still being working on in
>>> Junio's 'pu' branch of git.git.  It has a few issues still to be
>>> worked out so it hasn't been made part of one of the more stable
>>> branches yet (like 'next', 'master', or 'maint').
>> Well, until it's available on an official git release, it doesn't help me.
> 
> One of the reasons its hanging out in 'pu' still is that there is
> a lack of people who are interested in the feature, and thus not
> enough people are testing it.  Perhaps you might be able to lend
> a hand in that regard?

Sure, I can do that!  Can you give me some pointers?  I've never done 
development on git itself, so I don't know Junio or his pu (sorry, I couldn't 
resist :-)).

-- 
Timur Tabi
