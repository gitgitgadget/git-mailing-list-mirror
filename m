From: David Brown <git@davidb.org>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 18:12:12 -0700
Message-ID: <20071016011212.GA609@old.davidb.org>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com> <20070709173720.GS29994@genesis.frugalware.org> <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org> <4713FA4A.5090501@bluelane.com> <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Pete/Piet Delaney <pete@bluelane.com>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 03:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihaz0-0003Zh-Hg
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 03:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113AbXJPBMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 21:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbXJPBMT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 21:12:19 -0400
Received: from mail.davidb.org ([66.93.32.219]:49734 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999AbXJPBMS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 21:12:18 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.67 #1 (Debian))
	id 1Ihayi-0000CJ-PV; Mon, 15 Oct 2007 18:12:12 -0700
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Pete/Piet Delaney <pete@bluelane.com>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61060>

On Mon, Oct 15, 2007 at 05:45:44PM -0700, Linus Torvalds wrote:

>	git diff -U99 | viewdiff -

Do you have reference for viewdiff.  I can't seem to locate it.

>[ Quite frankly, I don't understand why tools like meld and kdiff3 can't 
>  just take the unified diff directly - they have *all* the logic, it 
>  should be trivial to do, and very useful to view diffs for those people 
>  who like that graphical bling. ]

kompare can read the unified diffs.  If you add enough context, the result
is no different than the full files.

David
