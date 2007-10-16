From: David Brown <git@davidb.org>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 18:13:25 -0700
Message-ID: <20071016011325.GB609@old.davidb.org>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <20070709173720.GS29994@genesis.frugalware.org> <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org> <4713FA4A.5090501@bluelane.com> <20071016000359.GT27899@spearce.org> <471408B8.8080509@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Pete/Piet Delaney <pete@bluelane.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 03:13:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihb09-0003kG-DC
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 03:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbXJPBNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 21:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbXJPBNb
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 21:13:31 -0400
Received: from mail.davidb.org ([66.93.32.219]:46052 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751778AbXJPBNb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 21:13:31 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1Ihazt-0000Ds-Cc; Mon, 15 Oct 2007 18:13:25 -0700
Mail-Followup-To: Pete/Piet Delaney <pete@bluelane.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <471408B8.8080509@bluelane.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61061>

On Mon, Oct 15, 2007 at 05:41:28PM -0700, Pete/Piet Delaney wrote:

>Try tkdiff and then tell me you don't find it easier to read that
>the straight output from diff.

Both.  Most of the time, I find the diff output easier to read.  Only when
a change modifies a whole bunch of lines sprinkled around do I find the
side-by-side format easier.  Even then, it is only marginal.

However, asking for a side-by-side diff viewer is probably the most common
request I've gotten from people I work with starting to use git.

David
