From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] Enable ref log creation in git checkout -b.
Date: Tue, 23 May 2006 21:32:28 -0700
Message-ID: <7vsln0qbz7.fsf@assigned-by-dhcp.cox.net>
References: <20060519091716.GM22257@spearce.org>
	<7vk68fyarn.fsf@assigned-by-dhcp.cox.net>
	<20060524035234.GA13329@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 06:32:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fil2v-0007XT-8n
	for gcvg-git@gmane.org; Wed, 24 May 2006 06:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWEXEca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 00:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbWEXEca
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 00:32:30 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41404 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932568AbWEXEc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 00:32:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524043229.IUQX9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 00:32:29 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060524035234.GA13329@spearce.org> (Shawn Pearce's message of
	"Tue, 23 May 2006 23:52:34 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20663>

Shawn Pearce <spearce@spearce.org> writes:

> Sure.  I've been putting it off as I've been busy the past few days
> and have also been thinking about trying to rebuild reflog using a
> tag/annotation branch style, which might be more generally useful
> to others.  So I've been debating about whether or not I should
> ask you to pop reflog out of pu indefinately.

Heh, too late for that -- it looked OK so now they are part of
"next" to get wider exposure.
