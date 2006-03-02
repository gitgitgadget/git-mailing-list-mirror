From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 11:44:05 -0500
Message-ID: <20060302164405.GB7292@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Mar 02 17:45:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEquS-0004au-4N
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 17:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWCBQoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 11:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbWCBQoI
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 11:44:08 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:17043 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1751586AbWCBQoH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 11:44:07 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 5D3F15A800C; Thu,  2 Mar 2006 11:44:05 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17092>

So to summarize:

If anyone has a problem with Cygwin where signals do not seem to be
working, I'd appreciate a bug report to the Cygwin list.  We really do
expect that things should work and want to fix things if they don't.

If that isn't possible to use the Cygwin list for some reason, I will
continue to read this mailing list and respond to Cygwin problems but I
would appreciate it if any Cygwin problem report contained details for
reproducing the problem.  We usually point people to this page
http://cygwin.com/problems.html when they have problems.  The basic take
away from that page is to provide the cygcheck output which shows what
settings have been used for your Cygwin installation.  The interesting
stuff in that output is the cygwin mount points, the CYGWIN environment
variable, and version information about the Cygwin DLL.

The Cygwin web site is http://cygwin.com/ and it has a lot of information
about Cygwin.  Some of it is undoubtedly out-of-date or unclear but we
do try to improve things if they are brought to our attention.

I don't see any reason to respond to this thread any further but I will
continue to rectify any misstatements that I see being made about
Windows or Cygwin here.

cgf (Cygwin Maintainer)
