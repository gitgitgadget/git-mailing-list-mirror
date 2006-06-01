From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport: Improved detection of merges.
Date: Thu, 01 Jun 2006 02:58:41 -0700
Message-ID: <7v64jlgpta.fsf@assigned-by-dhcp.cox.net>
References: <11490715283626-git-send-email-octo@verplant.org>
	<7vlkshs618.fsf@assigned-by-dhcp.cox.net>
	<20060601092238.GB9333@hand.yhbt.net>
	<20060601093603.GY2315@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 11:58:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fljx1-000163-EM
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 11:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWFAJ6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 05:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWFAJ6n
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 05:58:43 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:18098 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964896AbWFAJ6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 05:58:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060601095842.XEBS27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Jun 2006 05:58:42 -0400
To: Florian Forster <octo@verplant.org>
In-Reply-To: <20060601093603.GY2315@verplant.org> (Florian Forster's message
	of "Thu, 1 Jun 2006 11:36:03 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21114>

Florian Forster <octo@verplant.org> writes:

> On Thu, Jun 01, 2006 at 02:22:39AM -0700, Eric Wong wrote:
>> Nope, I haven't seen that nor Florian's patch (assuming it was sent to
>> the ml).  Ah, I just saw (part #2) pop up.
>
> sorry, I'm new to the git development and didn't know that patches
> should be sent to the ML. I've attached that patch I sent to Junio to
> this mail.

Thanks for a resend.

The patch is already queued in "next", so svn people might want
to take a peek there.
