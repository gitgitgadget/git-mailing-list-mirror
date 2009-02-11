From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] lis3lv02d: support both one- and two-byte sensors
Date: Wed, 11 Feb 2009 12:16:35 +0100
Message-ID: <4992B393.8070808@drmicha.warpmail.net>
References: <1234310519-14230-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>,
	Pavel Machek <pavel@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 12:18:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXD6X-0005ES-IY
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 12:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbZBKLQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 06:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbZBKLQm
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 06:16:42 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54548 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752994AbZBKLQl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 06:16:41 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 32E4428FC1E;
	Wed, 11 Feb 2009 06:16:40 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 11 Feb 2009 06:16:40 -0500
X-Sasl-enc: VzerCqjQU1Q73shLWiSX4lgbZCw55wTNVEr/nLvjQkuy 1234350999
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3E5B631948;
	Wed, 11 Feb 2009 06:16:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090209 Shredder/3.0b2pre
In-Reply-To: <1234310519-14230-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109407>

Giuseppe,

you may prefer sending this to the kernel mailing list rather than the
git list. But we can tell you the patch is formatted as a proper git
patch ;)

Cheers,
Michael
