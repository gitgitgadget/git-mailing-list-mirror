From: Pavel Roskin <proski@gnu.org>
Subject: Re: Navigating remote branches in qgit
Date: Wed, 07 Feb 2007 03:31:44 -0500
Message-ID: <1170837104.11150.128.camel@dv>
References: <1170574889.21644.38.camel@dv>
	 <e5bfff550702040300x60bb1dfdxd312dc214bc49014@mail.gmail.com>
	 <1170645235.4191.26.camel@dv.roinet.com>
	 <e5bfff550702050945l528b764apacc69b79c60dfb7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hKHICmAikTWCqkza6KAM"
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 09:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEiDp-0007ff-OS
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 09:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbXBGIbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 03:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbXBGIbs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 03:31:48 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:54477 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030488AbXBGIbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 03:31:47 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HEiCK-0006bn-Ho
	for git@vger.kernel.org; Wed, 07 Feb 2007 03:30:36 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HEiDQ-0000Vl-E4; Wed, 07 Feb 2007 03:31:44 -0500
In-Reply-To: <e5bfff550702050945l528b764apacc69b79c60dfb7a@mail.gmail.com>
X-Mailer: Evolution 2.9.5 (2.9.5-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38894>


--=-hKHICmAikTWCqkza6KAM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello, Marco!

Thank you for all your fixes!  You have greatly improved usability of
qgit for me.

On Mon, 2007-02-05 at 18:45 +0100, Marco Costalba wrote:

> In your interesting test case at http://www.red-bean.com/proski/qgit/
> all the remotes are on "origin", so in that case I don't see how
> things could go better. Or perhaps I don't have understand the
> grouping logic. In this case please give me some example based on your
> repo, so I can understand the algorithm to use.

Well, the only example with multiple remotes is my Linux repository, and
I'm afraid it would be too large.  So I'm attaching compressed output of
git-show-refs.

Actually, I'm not sure if multiple remotes is such a common case to add
a level in menu hierarchy just to support them.

My feeling is that the popup menu is already heavily overloaded, and
some things just need to be accessed from specialized dialogs.

I think some design decisions should come from git.  What are we going
to do if there are thousands of tags and branches?  How are we going to
sort them in git?

-- 
Regards,
Pavel Roskin

--=-hKHICmAikTWCqkza6KAM
Content-Disposition: attachment; filename=showref.bz2
Content-Type: application/x-bzip; name=showref.bz2
Content-Transfer-Encoding: base64

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



--=-hKHICmAikTWCqkza6KAM--
