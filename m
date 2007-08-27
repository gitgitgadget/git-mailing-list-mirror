From: Theodore Tso <tytso@mit.edu>
Subject: Re: Git User's Survey 2007 partial summary
Date: Mon, 27 Aug 2007 11:43:51 -0400
Message-ID: <20070827154351.GG4680@thunk.org>
References: <200708190128.43515.jnareb@gmail.com> <200708270251.05762.jnareb@gmail.com> <85tzqla5tn.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 17:43:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPgkw-0005bU-Ra
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 17:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbXH0Pn4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 11:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755936AbXH0Pnz
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 11:43:55 -0400
Received: from THUNK.ORG ([69.25.196.29]:51210 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755754AbXH0Pnz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 11:43:55 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IPgtk-0008Az-2u; Mon, 27 Aug 2007 11:53:04 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IPgkp-0006qn-AJ; Mon, 27 Aug 2007 11:43:51 -0400
Content-Disposition: inline
In-Reply-To: <85tzqla5tn.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56853>

On Mon, Aug 27, 2007 at 07:45:40AM +0200, David Kastrup wrote:
> I found guilt essentially unusable for me due to its documentation.
> There is only man-page level documentation for the various commands
> comprising it, but the overall design is just "this is just like patch
> sets in ..." uh, Monotone?  Don't remember which it was.  Anyway, the
> docs were quite useless to me as someone who did _not_ previously use
> the system mentioned as reference.

The system guilt is more like is "quilt".  For people who are using
pure patches to maintain changes against mainline, quilt is the "rcs"
of that particular problem domain.  It would probably be a good idea
to have a pointer to Andreas Gruenbacher's, "How To Surive With Many
Patches or Introduction to Quilt" paper.

						- Ted
