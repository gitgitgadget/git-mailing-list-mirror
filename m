X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git.kernel.org disconnects when git-1.3.3 tries to pull changes
Date: Mon, 30 Oct 2006 13:53:26 -0600
Message-ID: <1162238005.18278.33.camel@cashmere.sps.mot.com>
References: <453D583E.3010601@simon.arlott.org.uk>
	 <7vbqo2wlpl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 20:14:05 +0000 (UTC)
Cc: Simon Arlott <simon@arlott.org>, Git List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqo2wlpl.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30517>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GedK4-00039f-So for gcvg-git@gmane.org; Mon, 30 Oct
 2006 21:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932475AbWJ3UBZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 15:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWJ3UBZ
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 15:01:25 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:46287 "EHLO
 az33egw02.freescale.net") by vger.kernel.org with ESMTP id S932475AbWJ3UBY
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 15:01:24 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200]) by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
 k9UK0lf6004417; Mon, 30 Oct 2006 13:00:47 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2]) by
 az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9UK0jA0018362; Mon, 30
 Oct 2006 14:00:45 -0600 (CST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, 2006-10-23 at 20:23, Junio C Hamano wrote:
> Yes, this is a recent breakage.  Thanks for bringing it up.
> 
> We need at least a fix like this in 'maint'.

Oooo...  Sorry.  That looks like my bad.

Thanks.

jdl

