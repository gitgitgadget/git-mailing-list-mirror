From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: baffled again
Date: Tue, 23 Aug 2005 22:58:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508232258170.3317@g5.osdl.org>
References: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
 <12c511ca050823223333c41857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "tony.luck@intel.com" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 08:00:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7oI9-0000dV-Ul
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 07:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVHXF6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 01:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVHXF6k
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 01:58:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750770AbVHXF6j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 01:58:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7O5wajA002714
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Aug 2005 22:58:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7O5wZBm029999;
	Tue, 23 Aug 2005 22:58:35 -0700
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca050823223333c41857@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7704>



On Tue, 23 Aug 2005, Tony Luck wrote:
> 
> So GIT decides that the test branch has had a patch, and the release
> branch hasn't ... and so it merges by keeping the version in test.
> 
> Plausible?

Very. Sounds like what happened.

		Linus
