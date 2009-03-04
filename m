From: =?UTF-8?B?VG9yIEFybmUgVmVzdGLDuA==?= <torarnv@gmail.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial branch
Date: Wed, 4 Mar 2009 11:23:56 +0100
Message-ID: <49AE56BC.2000809@gmail.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII";
	format="flowed"
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:25:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeoHp-0002dp-C1
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbZCDKXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbZCDKXp
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:23:45 -0500
Received: from hoat.troll.no ([62.70.27.150]:45721 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbZCDKXo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:23:44 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 1150920FA0;
	Wed,  4 Mar 2009 11:23:42 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id EE4E220F9E;
	Wed,  4 Mar 2009 11:23:41 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n24ANfIX012507;
	Wed, 4 Mar 2009 11:23:41 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Wed, 04 Mar 2009 11:23:41 +0100 (CET)
In-Reply-To: <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
References: <1236040414-19089-1-git-send-email-torarnv@gmail.com>
References: <7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112198>

Junio C Hamano wrote:
> I'll let others discuss more about the design issues, and will only talk
> about code in this message.

[...snip...]

Great feedback, much appreciated! :) I'll work up a new patch as soon as 
I have some free cycles. Thanks!

Tor Arne
