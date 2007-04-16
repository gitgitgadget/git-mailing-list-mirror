From: Theodore Tso <tytso@mit.edu>
Subject: Re: Mozilla picks a DSCM system.... an amusing read
Date: Mon, 16 Apr 2007 06:26:58 -0400
Message-ID: <20070416102658.GD27533@thunk.org>
References: <E1HdCMO-0002kW-Lx@candygram.thunk.org> <46a038f90704152126v4c214a9at76870abffeccb611@mail.gmail.com> <46a038f90704152127t43949a51h601e35cc4fc6aa7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 12:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdOQR-0002uB-9o
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 12:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbXDPK1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 06:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbXDPK1H
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 06:27:07 -0400
Received: from thunk.org ([69.25.196.29]:47153 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030325AbXDPK1G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 06:27:06 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HdOWh-00075B-RG; Mon, 16 Apr 2007 06:33:40 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HdOQE-0000nr-Kg; Mon, 16 Apr 2007 06:26:58 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90704152127t43949a51h601e35cc4fc6aa7d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44638>

On Mon, Apr 16, 2007 at 04:27:51PM +1200, Martin Langhoff wrote:
> On 4/16/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >From a git POV, this is only the 2nd-best scenario -- once they are on
> >hg, the barriers of migration to git are much lower.
> 
> Specially if we write git-hgserver sometime soon ;-)

Yeah, if I could clone myself or otherwise get a few weeks of
uninterrupted hacking time, I'd be writing a bidrectional hg<->git
gateway.... it's the main reason at this point why I haven't switched
e2fsprogs to git.

						- Ted
