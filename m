From: Peter Eisentraut <peter_e@gmx.net>
Subject: Context diffs
Date: Sun, 20 Apr 2008 22:52:09 +0200
Message-ID: <200804202252.10394.peter_e@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 22:53:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JngWx-0001eD-E4
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 22:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbYDTUwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbYDTUwO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 16:52:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:55364 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750997AbYDTUwN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 16:52:13 -0400
Received: (qmail invoked by alias); 20 Apr 2008 20:52:11 -0000
Received: from xdsl-213-196-202-104.netcologne.de (EHLO colt.local) [213.196.202.104]
  by mail.gmx.net (mp053) with SMTP; 20 Apr 2008 22:52:11 +0200
X-Authenticated: #495269
X-Provags-ID: V01U2FsdGVkX1/cLP4MVsncIHqKLIHwbihQwPe9FbnxnYZAgNxjln
	ouUb9JWkFzA9NA
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79984>

Would it be possible to support context diffs (like diff -c) in git-diff?  In 
many cases these are easier to interpret than the unified diff format.

I know I can do this via an external diff wrapper, but it'd be nicer if this 
were built in, considering that it is a very common format.
