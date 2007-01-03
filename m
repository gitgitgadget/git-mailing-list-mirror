From: Theodore Tso <tytso@mit.edu>
Subject: Re: [DRAFT] Branching and merging with git
Date: Wed, 3 Jan 2007 12:04:11 -0500
Message-ID: <20070103170411.GB5491@thunk.org>
References: <20061116221701.4499.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 18:04:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H29XK-0001T0-0b
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 18:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbXACRET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 12:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbXACRET
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 12:04:19 -0500
Received: from thunk.org ([69.25.196.29]:52319 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbXACRES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 12:04:18 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H29bY-0006kr-H4; Wed, 03 Jan 2007 12:08:44 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H29X9-0003Z0-6H; Wed, 03 Jan 2007 12:04:11 -0500
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20061116221701.4499.qmail@science.horizon.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35879>

On Thu, Nov 16, 2006 at 05:17:01PM -0500, linux@horizon.com wrote:
> I know it took me a while to get used to playing with branches, and I
> still get nervous when doing something creative.  So I've been trying
> to get more comfortable, and wrote the following to document what I've
> learned.

What ever happened to this document?  There was some talk of getting
this integrated into the git tree as Docmentation/tutorial-3.txt.
IMHO it would be really, really good to do this before 1.5.0, since I
think a lot of users would find it really useful.  Some of the text
may need to be moved to other locations, but it might go faster if we
get the base document into the tree first, and then we can submit
patches to move text around to integrate it into the other
documentation files.

I'm certainly willing to help out submitting patches to improve the
documentation, and I think this would be a big step towards helping
new users to git become much more quickly proficient.

						- Ted
