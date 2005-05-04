From: "Brian O'Mahoney" <omb@khandalf.com>
Subject: Sym-links, b/c-special files, pipes, ... Scope Creep
Date: Wed, 04 May 2005 02:39:19 +0200
Message-ID: <427819B7.3010706@khandalf.com>
References: <1115145234.21105.111.camel@localhost.localdomain>
    <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
    <Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
    <Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>
    <7vr7got2tz.fsf@assigned-by-dhcp.cox.net>
    <Pine.LNX.4.58.0505031446220.31626@sam.ics.uci.edu>
    <7v8y2wszdy.fsf@assigned-by-dhcp.cox.net>
Reply-To: omb@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 02:33:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT7og-0008FN-0h
	for gcvg-git@gmane.org; Wed, 04 May 2005 02:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVEDAjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 20:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVEDAjA
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 20:39:00 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:59364 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261958AbVEDAi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 20:38:58 -0400
Received: from khandalf.com (80-218-57-125.dclient.hispeed.ch [80.218.57.125])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id j440ctKl003192
	for <git@vger.kernel.org.>; Wed, 4 May 2005 02:38:57 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
    teraflex.teraflex-research.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
    id j440dJWY025760; Wed, 4 May 2005 02:39:22 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8y2wszdy.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Md5-Body: 3c1f50234dc8bf9e7f441bf30e53e3db
X-Transmit-Date: Wednesday, 4 May 2005 2:39:33 +0200
X-Message-Uid: 0000b49cec9d88840000000200000000427819c5000992b300000001000a237b
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on smtp-07.tornado.cablecom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Caution, let us all carefully understand the Source-Code/
Configuration Management issue.

I for one will be very happy if we get a really good distributed
SCM out of this.

Brian
