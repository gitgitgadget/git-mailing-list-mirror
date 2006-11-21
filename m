X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not
 so large)?
Date: Tue, 21 Nov 2006 15:49:11 -0600
Organization: Freescale
Message-ID: <45637457.1010505@freescale.com>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net> <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org> <45632EC6.5030902@freescale.com> <20061121165656.GC22006@spearce.org> <456330CD.9080503@freescale.com> <20061121183941.GB22283@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 21:49:41 +0000 (UTC)
Cc: Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
In-Reply-To: <20061121183941.GB22283@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32042>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmdUY-0007Og-5d for gcvg-git@gmane.org; Tue, 21 Nov
 2006 22:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161393AbWKUVtS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 16:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161401AbWKUVtS
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 16:49:18 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:10462 "EHLO
 de01egw01.freescale.net") by vger.kernel.org with ESMTP id S1161393AbWKUVtR
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 16:49:17 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net
 [10.208.0.31]) by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
 kALNAwIe023205; Tue, 21 Nov 2006 16:10:58 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
 by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kALLnCD4029913; Tue,
 21 Nov 2006 15:49:12 -0600 (CST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> finally you can either run from that directory (see INSTALL file)
> or you can install the binary somewhere else.  We don't really
> recommend using `pu` for production level work, so make sure you
> have a backup of any repository you run it on.  :)

So how do I make a shallow clone?  I've set it all up, but there is no 
git-shallow-clone command, and git help clone doesn't have anything either.


-- 
Timur Tabi
