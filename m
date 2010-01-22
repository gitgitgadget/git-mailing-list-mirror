From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: PATCH 2/5] make "mktag" a built-in
Date: Fri, 22 Jan 2010 08:33:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001220832300.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain> <alpine.LFD.2.00.1001220822560.13231@localhost.localdomain> <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:36:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMUJ-00021L-DL
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619Ab0AVQfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753595Ab0AVQff
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:35:35 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52905 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753502Ab0AVQfd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:35:33 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGXaF6017228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:33:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGXZ0I015461;
	Fri, 22 Jan 2010 08:33:36 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.1001220825190.13231@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137763>


Oops, I screwed up the subject line on this one (obvious missing opening 
brace, since I'm a tool and can't cut-and-paste correctly). So please fix 
that before applying.

		Linus
