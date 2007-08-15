From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch -	scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 13:44:39 +0200
Message-ID: <46C2E727.3050407@gmail.com>
References: <1186984174.10249.7.camel@localhost>	 <200708131933.10125.m.kozlowski@tuxland.pl>	 <1187026955.2688.4.camel@laptopd505.fenrus.org>	 <1187037445.6628.98.camel@heimdal.trondhjem.org>	 <1187054366.2757.0.camel@laptopd505.fenrus.org>	 <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>	 <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>	 <7vwsvx8twx.fsf@assigned-by-dhcp.cox.net> <1187143925.32555.208.camel@localhost> <46C2C9DC.9030307@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Joe Perches <joe@perches.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 13:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILHNO-0002hj-Ra
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 13:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXHOLsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 07:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXHOLsx
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 07:48:53 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:38741 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbXHOLsw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 07:48:52 -0400
Received: from [213.51.130.190] (port=37753 helo=smtp1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1ILHMX-0007Vu-9q; Wed, 15 Aug 2007 13:48:33 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:56619 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1ILHMV-00045o-29; Wed, 15 Aug 2007 13:48:31 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <46C2C9DC.9030307@s5r6.in-berlin.de>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55893>

On 08/15/2007 11:39 AM, Stefan Richter wrote:

> Note, maintainer contacts
>   - should be available to patch submitters and
>   - must be available to *problem reporters*
> without having to have git and a .git repo.

That "must" seems rather strong. But those few non-developer users that 
could care are served by a MAINTAINERS file generated into releases.

Rene.
