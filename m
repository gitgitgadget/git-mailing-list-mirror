From: Theodore Tso <tytso@mit.edu>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 20:12:40 -0400
Message-ID: <20071024001240.GB6404@thunk.org>
References: <20071023020044.GA27132@thunk.org> <20071023040522.GX14735@spearce.org> <20071023043321.GC27132@thunk.org> <20071023044657.GC14735@spearce.org> <20071023045632.GD27132@thunk.org> <20071023050726.GD14735@spearce.org> <20071023053003.GE27132@thunk.org> <20071023054238.GE14735@spearce.org> <20071023120338.GG27132@thunk.org> <7vtzoh7j1l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 07:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkYuK-0000U6-0D
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 07:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbXJXFfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 01:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754406AbXJXFfF
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 01:35:05 -0400
Received: from thunk.org ([69.25.196.29]:51842 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349AbXJXFfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 01:35:03 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IkZ3G-0007Xa-02; Wed, 24 Oct 2007 01:45:10 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@thunk.org>)
	id 1IkTrU-0001fd-VI; Tue, 23 Oct 2007 20:12:40 -0400
Content-Disposition: inline
In-Reply-To: <7vtzoh7j1l.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62192>

On Tue, Oct 23, 2007 at 12:00:38PM -0700, Junio C Hamano wrote:
> 
> You can view 'next' as if it is sort of -mm.  Following 'master'
> is like following Linus tree, whose development is without those
> numerous 'merge improvements again' merges into 'next'.

Actually -mm is much closer to 'pu', since it can and is rewound all
the time.  Patches can disappear if they are causing problems, they
can be replaced and reworked, etc.

						- Ted
