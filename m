From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -	scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 11:39:40 +0200
Message-ID: <46C2C9DC.9030307@s5r6.in-berlin.de>
References: <1186984174.10249.7.camel@localhost>	 <200708131933.10125.m.kozlowski@tuxland.pl>	 <1187026955.2688.4.camel@laptopd505.fenrus.org>	 <1187037445.6628.98.camel@heimdal.trondhjem.org>	 <1187054366.2757.0.camel@laptopd505.fenrus.org>	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>	 <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net> <1187143925.32555.208.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Rene Herman <rene.herman@gmail.com>, git@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 11:40:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILFMV-00058t-TE
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 11:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbXHOJjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 05:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbXHOJjm
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 05:39:42 -0400
Received: from hp3.statik.tu-cottbus.de ([141.43.120.68]:37545 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbXHOJjl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 05:39:41 -0400
Received: from [141.43.120.89] (ap10.statik.tu-cottbus.de [141.43.120.89])
	by hp3.statik.tu-cottbus.de (Postfix) with ESMTP id 2A53E396EC;
	Wed, 15 Aug 2007 11:39:40 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4
In-Reply-To: <1187143925.32555.208.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55890>

Joe Perches wrote:
> On Tue, 2007-08-14 at 18:31 -0700, Junio C Hamano wrote:
>>    On the other hand, git-send-email _is_ all about sending it
>>    out, and it needs to know who your patch should reach.  I
>>    think it makes sense to have one script that,
[...]

> Yes please.
> 
> The LK MAINTAINERS file is ugly.
> 
> Might there be a git portable way to "find"?

Note, maintainer contacts
  - should be available to patch submitters and
  - must be available to *problem reporters*
without having to have git and a .git repo.
-- 
Stefan Richter
-=====-=-=== =--- -====
http://arcgraph.de/sr/
