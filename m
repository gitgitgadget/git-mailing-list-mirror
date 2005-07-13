From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] stgit: allow spaces in filenames
Date: Wed, 13 Jul 2005 15:26:39 -0700
Message-ID: <7vpstms5pc.fsf@assigned-by-dhcp.cox.net>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>
	<tnxll4bdn7b.fsf@arm.com> <42D55AC9.4000506@gmail.com>
	<1121290004.6876.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 20:08:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt87j-0006Re-0S
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 20:07:51 +0200
Received: from vger.kernel.org (vger.kernel.org [12.107.209.244])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id j6DMT8MS023261
	for <gcvg-git@gmane.org>; Thu, 14 Jul 2005 00:29:09 +0200 (CEST)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVGMW2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 18:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVGMW0x
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 18:26:53 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49095 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262794AbVGMW0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 18:26:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050713222639.NLHV17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 18:26:39 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1121290004.6876.11.camel@localhost.localdomain> (Catalin Marinas's message of "Wed, 13 Jul 2005 22:26:44 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

>> I'd very much like to stay on the same list.  By the same logic, cogito 
>> should have it's own list as well...
>
> I'd like this too and it's probably OK with a low traffic (we'll see if
> we receive complaints :-) ).

I'd like to keep Porcelain discussions on this list for two
reasons:

 (1) Porcelain implementations need their own bookkeeping
     information somewhere, and possibly in .git/ directory.
     I'd want to see them agree on what's stored where for what
     purpose and stay compatible when that makes sense.  The
     place to brew that concensus is here.

 (2) The core GIT people want to learn what Porcelain needs
     from the core.  I am personally interested in StGIT so
     subscribing to that list is fine for me, but it is
     convenient to have everything in one place, especially with
     this relatively low traffic.
