From: Junio C Hamano <junkio@cox.net>
Subject: Re: [OT?] git tools at SourceForge ?
Date: Fri, 12 Aug 2005 13:36:40 -0700
Message-ID: <7vr7cysxif.fsf@assigned-by-dhcp.cox.net>
References: <20050812190739.AC222352633@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 22:38:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3gH5-000472-AO
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 22:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVHLUgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 16:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVHLUgo
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 16:36:44 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50051 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750861AbVHLUgo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 16:36:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812203641.QEWI15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 16:36:41 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050812190739.AC222352633@atlas.denx.de> (Wolfgang Denk's
	message of "Fri, 12 Aug 2005 21:07:39 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wolfgang Denk <wd@denx.de> writes:

> Has anybody any information if SourceForge is going to provide git  /
> cogito / ... for the projects they host? I asked SF, and they openend
> a new Feature Request (item #1252867); the message I received sounded
> as if I was the first person on the planet to ask...
>
> Am I really alone with this?

Earlier Johannes Schindelin sent in a bug report he found on one
architecture in their build farm, so apparently he has access to
it.

I'd actually welcome people who have access to such a build
network, time and of course willingness to start portability
fixes on various platforms for git-core.
