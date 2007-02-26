From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] qgit-1.5.5
Date: Mon, 26 Feb 2007 20:37:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702262035480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702250958n6cddc5b5lec4badf1f7fc8231@mail.gmail.com> 
 <46a038f90702251623h5944a085m514418cb5f530e7f@mail.gmail.com> 
 <e5bfff550702252219m352c03ady2d810e051bd62a37@mail.gmail.com> 
 <Pine.LNX.4.63.0702261218430.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <e5bfff550702260939t4a071d34o6bbf3dcd4ad5b67c@mail.gmail.com> 
 <Pine.LNX.4.63.0702261846010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702261129p5085bd22gae11c81b401d3591@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 26 20:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLlf7-0004Ux-Um
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 20:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbXBZTh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 14:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030491AbXBZTh0
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 14:37:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:48500 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030479AbXBZThZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 14:37:25 -0500
Received: (qmail invoked by alias); 26 Feb 2007 19:37:24 -0000
X-Provags-ID: V01U2FsdGVkX18pEk4TYzIpwo5pABFWCdchZ9BtRVKu4PPvpBZ0xo
	pDfQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550702261129p5085bd22gae11c81b401d3591@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40648>

Hi,

On Mon, 26 Feb 2007, Marco Costalba wrote:

> On 2/26/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Mon, 26 Feb 2007, Marco Costalba wrote:
> > 
> > > Actually, I didn't test with MinGW port of Git but I would be surprised
> > > if it doesn't work (famous last words ;-)  )
> > 
> > You don't use cygpath to translate between Windows <-> POSIX filenames?
> > 
> > AFAICT this is the single most important user-visible difference 
> > between Cygwin Git and MinGW Git.
> > 
> 
> I call git programs as if they were native windows programs. I run git 
> programs without requiring cygwin shell or something similar.

Actually, what I was getting at is the silly "Drive:\bla" filename syntax 
on Windows boxen. But

- you have to cd to the working directory in order to start the git 
  programs, and
- AFAIK Windows is not stupid enough to forbid "dir/name" syntax.

So, all my objections are invalid.

> I hope I have understood correctly your answer.

Yes ;-)

Ciao,
Dscho
