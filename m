X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 14:37:57 -0600
Message-ID: <1164832677.4724.60.camel@cashmere.sps.mot.com>
References: <45357CC3.4040507@utoronto.ca> <87slhcz8zh.wl%cworth@cworth.org>
	 <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
	 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
	 <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
	 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
	 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
	 <456B7C6A.80104@webdrake.net>
	 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
	 <ekhaeg$etk$1@sea.gmane.org>
	 <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
	 <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>
	 <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de>
	 <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
	 <456CB197.2030201@onlinehome.de>
	 <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
	 <Pine.LNX.4.64.0611281432300.4244@woody.osdl.org>
	 <456CBCD5.3050505@onlinehome.de>
	 <Pine.LNX.4.63.0611291145510.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 20:41:39 +0000 (UTC)
Cc: Nicholas Allen <nick.allen@onlinehome.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, Git List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611291145510.30004@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32665>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpWFA-0008CE-9T for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967646AbWK2UlU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967661AbWK2UlU
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:41:20 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:33728 "EHLO
 az33egw02.freescale.net") by vger.kernel.org with ESMTP id S967646AbWK2UlT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:41:19 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199]) by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
 kATKck4V003202; Wed, 29 Nov 2006 13:38:46 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2]) by
 az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kATKci6U018785; Wed, 29
 Nov 2006 14:38:44 -0600 (CST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, 2006-11-29 at 04:49, Johannes Schindelin wrote:

> As for your scenario: There really should be a "what to do when my merge 
> screwed up?" document.

I have a few examples scenarios and some notes on
cleaning up after failed merges in my slides from
the presentation I did at OLS last summer.

Feel free to look at it off of www.jdl.com!

jdl

