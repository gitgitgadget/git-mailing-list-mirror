From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Sat, 13 Dec 2008 00:30:32 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <31385.1229128232@redhat.com>
References: <4942C2D1.4090309@garzik.org> <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sat Dec 13 01:32:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBIQM-0008K6-CS
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 01:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYLMAan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 19:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYLMAan
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 19:30:43 -0500
Received: from mx2.redhat.com ([66.187.237.31]:55253 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbYLMAam (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 19:30:42 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mBD0UZtg000320;
	Fri, 12 Dec 2008 19:30:35 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mBD0UY6d025157;
	Fri, 12 Dec 2008 19:30:34 -0500
Received: from warthog.cambridge.redhat.com (kibblesnbits.boston.devel.redhat.com [10.16.60.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mBD0UWMk021906;
	Fri, 12 Dec 2008 19:30:33 -0500
Received: from [127.0.0.1] (helo=redhat.com)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LBIOu-0008AE-LS; Sat, 13 Dec 2008 00:30:32 +0000
In-Reply-To: <4942C2D1.4090309@garzik.org>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102969>

Jeff Garzik <jeff@garzik.org> wrote:

> What do you feel is missing from the Kernel Hackers' Guide to Git?  :)

Quite a lot.  Most notably the section I have on publishing changes by GIT
tree.  It's taken a lot of experimentation to work out how to do it, and I'm
sure it can be done better.  I hadn't managed to find anywhere on the web
describing how to do it that I could follow, and no-one that I asked was really
willing to help me set it up.

I have a number of crib sheets that I've cobbled together to note how to do
things that I can cut and paste from, so I turned them into a document.

David
