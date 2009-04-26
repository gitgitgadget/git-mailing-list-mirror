From: Miles Bader <miles@gnu.org>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and Mercurial
Date: Mon, 27 Apr 2009 07:24:13 +0900
Message-ID: <87tz4bgik2.fsf@catnip.gol.com>
References: <200904260703.31243.chriscool@tuxfamily.org>
	<alpine.DEB.1.00.0904261208000.10279@pacific.mpi-cbg.de>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:38:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyCxk-0001yu-SX
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 00:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbZDZWfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 18:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZDZWfH
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 18:35:07 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:50641 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZDZWfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 18:35:06 -0400
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2009 18:35:06 EDT
Received: from 218.231.174.23.eo.eaccess.ne.jp ([218.231.174.23] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1LyCli-0007kM-8A; Mon, 27 Apr 2009 07:24:14 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 4CB16DF72; Mon, 27 Apr 2009 07:24:13 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <alpine.DEB.1.00.0904261208000.10279@pacific.mpi-cbg.de>
	(Johannes Schindelin's message of "Sun, 26 Apr 2009 12:13:23 +0200
	(CEST)")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117611>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> So, don't believe that the reason Git is not supported by Google Code is a 
> technical one (just like it was no technical reason at all for Python to 
> choose Hg over Git).

I look at it this way:  having added another VCS to the previously
subversion-only google-code, they've probably generalized parts of their
framework in a way that should make it much easier to add git support in
the future!

Maybe it's time to file another git support request at google code...

:-)

-Miles

-- 
Patience, n. A minor form of despair, disguised as a virtue.
