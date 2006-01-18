From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] What is a tag for?
Date: Wed, 18 Jan 2006 10:19:52 -0800
Message-ID: <7vfynlwg8n.fsf@assigned-by-dhcp.cox.net>
References: <1137538344.9104.34.camel@malory> <43CE19F2.6000709@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:20:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHv0-0002Nu-R5
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWARST4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWARST4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:19:56 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:33713 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030233AbWARSTz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 13:19:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118181959.VEUL25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 13:19:59 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14851>

Andreas Ericsson <ae@op5.se> writes:

> I'd recommend not allowing un-annotated tags in your shared repo. I
> sent a patch for the default update-hook sometime ago that disallows
> this. Junio seemed happy about it so I don't understand why it hasn't
> been pushed to the master branch yet.

Most likely lost in the noise.  I probably have it in my mailbox
but not applied in any of my private branches in my repository.
