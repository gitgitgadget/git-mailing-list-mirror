From: Theodore Tso <tytso@mit.edu>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 20:49:24 -0500
Message-ID: <20070221014924.GC27391@thunk.org>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org> <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org> <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 21 02:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJgc2-0007s8-8Z
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 02:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXBUBtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 20:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbXBUBtd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 20:49:33 -0500
Received: from thunk.org ([69.25.196.29]:50310 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbXBUBtc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 20:49:32 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HJgh6-0006ju-FD; Tue, 20 Feb 2007 20:54:56 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HJgbk-0004jZ-Ae; Tue, 20 Feb 2007 20:49:24 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40274>

On Wed, Feb 21, 2007 at 01:39:48AM +0100, Johannes Schindelin wrote:
> In that case, .gitattributes (I mean a tracked one) would be wrong, wrong, 
> wrong.

Well, some of the uses of .gitattributes that I had propose was to
associate file types (and from the file types, a set of check-in,
check-out, diff, and pretty-print helper progams) for things like
OpenOffice files.

For those a tracked .gitattributes makes a lot of sense.

						- Ted
