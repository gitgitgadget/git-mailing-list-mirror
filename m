From: Theodore Tso <tytso@mit.edu>
Subject: Re: mercurial to git
Date: Wed, 14 Mar 2007 20:25:07 -0400
Message-ID: <20070315002505.GA31770@thunk.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu> <20070307001105.GJ18370@thunk.org> <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdmY-0002JW-Lh
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbXCOAZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbXCOAZX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:25:23 -0400
Received: from thunk.org ([69.25.196.29]:46685 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964919AbXCOAZX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:25:23 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HRds7-0002ZY-3s; Wed, 14 Mar 2007 20:31:11 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HRdmF-0003pj-PD; Wed, 14 Mar 2007 20:25:07 -0400
Content-Disposition: inline
In-Reply-To: <20070314111257.GA4526@peter.daprodeges.fqdn.th-h.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42254>

On Wed, Mar 14, 2007 at 11:12:57AM +0000, Rocco Rutte wrote:
> 
> I tried the import on the e2fsprogs repo and the files come out 
> identical, authors/comitters look okay to me, too.

Very cool!  It looks like some of the git author dates are only
getting set if the -s flag is set.  Was that intentional?

						- Ted
