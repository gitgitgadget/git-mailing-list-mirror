From: Sam Vilain <sam@vilain.net>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 14:40:43 +1200
Message-ID: <46D239AB.8060209@vilain.net>
References: <20070826235944.GM1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 27 04:40:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPUWx-0002Pg-4U
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 04:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbXH0CkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 22:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbXH0CkJ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 22:40:09 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52909 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbXH0CkI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 22:40:08 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id ABA2521CFA3; Mon, 27 Aug 2007 14:40:05 +1200 (NZST)
Received: from [203.97.235.49] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id D1B7D2052F2;
	Mon, 27 Aug 2007 14:40:00 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20070826235944.GM1219@pasky.or.cz>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56757>

Petr Baudis wrote:
>   Hi,
>
>   I've just finally killed the HTTP auth for project administration that
> was destroying everyone's lives, and added support for resetting
> forgotten passwords, two main things that seemed to be the popular nits
> of the repo.or.cz audience.
>
>   So now I wonder, what is the thing you miss most there? Any cool stuff
> repo.or.cz could (preferrably easily) do and doesn't?
>
>   And please don't ask for smaller roundtrip times of requests for
> administrator assistance. ;-)
>   

I'd like to see the service mirrored, including potentially a repository
which contains the meta/auth information (sans password hashes, perhaps)
for admins on accounts.

This of course opens a large can of worms when it comes to achieving
decentralization of the service as a whole, however I think those
questions will be best answered once the information is available for
setting up mirrors.

I've also got hardware, bandwidth and some tuits.

Sam.
