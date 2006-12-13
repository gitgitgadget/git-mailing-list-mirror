X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC/PATCH] runstatus: restructure visual appearance
Date: Wed, 13 Dec 2006 10:12:15 -0600
Message-ID: <1166026335.19135.462.camel@cashmere.sps.mot.com>
References: <11650882251452-git-send-email-hjemli@gmail.com>
	 <8c5c35580612120330n36bcdd00p57b2a7cd1d6c801@mail.gmail.com>
	 <7v3b7koc6b.fsf@assigned-by-dhcp.cox.net>
	 <8c5c35580612130127y1b094dbbq34c06376704b0506@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 19:08:26 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Git List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 96820 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 14:08:07 EST
In-Reply-To: <8c5c35580612130127y1b094dbbq34c06376704b0506@mail.gmail.com>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34384>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuvwL-0007XN-Ca for gcvg-git@gmane.org; Thu, 14 Dec
 2006 20:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932886AbWLNTII (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 14:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWLNTII
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 14:08:08 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:43085 "EHLO
 az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932886AbWLNTIH (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 14:08:07 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200]) by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
 kBDGEJ0O027670; Wed, 13 Dec 2006 09:14:19 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2]) by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id kBDGEIcn019337; Wed, 13
 Dec 2006 10:14:18 -0600 (CST)
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org

On Wed, 2006-12-13 at 03:27, Lars Hjemli wrote:

> >If we are designing a new format to make git-status output more
> >compact and easier to understand, I think it should also attempt
> >to address this [mode-change] problem as well.
> 
> Excellent point, I'll use it as an excuse to refine and resend the patch.

If you are so inclined, you might google on list for a
patch I submitted down this line last year sometime?

jdl

