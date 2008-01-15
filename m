From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 17:11:11 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0801151709330.5289@eeepc-johanness>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>  <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>  <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>  <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness> 
 <c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com>  <alpine.DEB.1.00.0801151650240.5289@eeepc-johanness> <c0f2d4110801150907y59593407u820c7b3db556ed31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chris Ortman <chrisortman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 18:12:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEpKo-00061L-9y
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 18:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYAORLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 12:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbYAORLP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 12:11:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:51834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751846AbYAORLO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 12:11:14 -0500
Received: (qmail invoked by alias); 15 Jan 2008 17:11:12 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp053) with SMTP; 15 Jan 2008 18:11:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UOcUSz0ZUla1N8ypzWOtoQ3rzoTvoMngdu2Ae0Y
	MdgI8r6cV8KseY
X-X-Sender: user@eeepc-johanness
In-Reply-To: <c0f2d4110801150907y59593407u820c7b3db556ed31@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70536>

Him

On Tue, 15 Jan 2008, Chris Ortman wrote:

> Should this be a new command in git-svn.perl? or something in contrib?

I'd just start with an alias at first, and if it develops into something 
you're happy with, send it here and let others comment on it -- also where 
it should go.

Possibly the best place really would be git-svn, but it might also be less 
interesting for other people, given that git-svn does not work in msysGit 
yet (and your use case was for TortoiseSVN, which is Windows-only).

Ciao,
Dscho
