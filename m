From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 21:15:31 +0100
Message-ID: <200702022115.31571.jnareb@gmail.com>
References: <200702010058.43431.jnareb@gmail.com> <Pine.LNX.4.64.0702021130020.15057@woody.linux-foundation.org> <20070202195504.GC7963@ventoux.cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	mercurial@selenic.com, git@vger.kernel.org
To: Brendan Cully <brendan@kublai.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 21:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD4nb-0005GG-Bh
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 21:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946040AbXBBUOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 15:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946041AbXBBUOM
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 15:14:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:49261 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946040AbXBBUOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 15:14:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so858535uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 12:14:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=V+50tWo+jS7fAbFQKUt/CKlLJ8sxWvpjKJ44x33FVmBUmuTneZh3amCyPtAyYJ2NsAkv3+NIQQ7m0B6h124XnCltzX9SPwjrHP1TecDhZ3Bo+vmwcUNfH65vH6/gr01eLERp0tp7MokaqVdJwWKt+oQkpfvEjRPdnp+NET1ZSNk=
Received: by 10.67.106.3 with SMTP id i3mr4886650ugm.1170447250244;
        Fri, 02 Feb 2007 12:14:10 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 32sm5899582ugf.2007.02.02.12.14.09;
        Fri, 02 Feb 2007 12:14:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070202195504.GC7963@ventoux.cs.ubc.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38533>

Brendan Cully wrote:

> Just because a tag is created at a different time than the revision it
> tags, that doesn't mean that it is ahistorical. It's still interesting
> to know what the state of the repository was when the tag was
> created.

I think not. Why would one want to know what was the state of the 
repository when the tag (perhaps to some historical, old commit)
was created?

-- 
Jakub Narebski
Poland
