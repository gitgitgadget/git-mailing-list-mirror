From: David Brown <git@davidb.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 22:09:18 -0700
Message-ID: <20081102050917.GA26634@linode.davidb.org>
References: <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm> <20081101010011.GG14786@spearce.org> <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm> <20081101010824.GE29036@artemis.corp> <alpine.LFD.2.00.0810312121000.13034@xanadu.home> <20081101014336.GI14786@spearce.org> <alpine.LFD.2.00.0810312150200.13034@xanadu.home> <20081101225714.GD15463@spearce.org> <d411cc4a0811011726h1fb1ad0ct5c37af753940f4a4@mail.gmail.com> <d411cc4a0811011807g229f8becs9f411d6e19fb6c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>, david@lang.hm,
	git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 06:10:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwVEU-0005ZD-Tm
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 06:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbYKBFJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 01:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbYKBFJY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 01:09:24 -0400
Received: from linode.davidb.org ([72.14.176.16]:51976 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbYKBFJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 01:09:23 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KwVDC-0006yW-12; Sat, 01 Nov 2008 22:09:18 -0700
Content-Disposition: inline
In-Reply-To: <d411cc4a0811011807g229f8becs9f411d6e19fb6c12@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99814>

On Sat, Nov 01, 2008 at 06:07:04PM -0700, Scott Chacon wrote:

>Think about trying to incorporate this into something proprietary,
>Shawn - how much of a pain is it going to be to get that license
>reviewed in Google?  However, LGPL I'm sure there is already a
>reviewed policy.  Now, since that may be a pain, time that Shawn could
>have been spending being paid to work on the library is lost because
>they can't use it, or it takes weeks/months to review it.  That's my
>concern.

The gcc exception license should have been reviewed by anyone who has
ever build anything proprietary out of gcc.

GPL+link exception is a very common license.  It's most common use is
for runtime libraries for various programming languages.

Lawyers I know are significantly less fearful of the GPL+exception
than the LGPL.  The exception basically says that if you use it in a
certain way, then none of the GPL applies.

David
