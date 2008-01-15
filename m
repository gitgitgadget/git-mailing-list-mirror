From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 16:13:22 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>  <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chris Ortman <chrisortman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEoQD-0006uH-0d
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 17:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbYAOQNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 11:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbYAOQNY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 11:13:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:47079 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750926AbYAOQNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 11:13:24 -0500
Received: (qmail invoked by alias); 15 Jan 2008 16:13:22 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp053) with SMTP; 15 Jan 2008 17:13:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AFRUzaWkA7d1vfuB3GmmRQwiuT4WpkAD+UZuvk1
	Hq4xfeNS1K5vOK
X-X-Sender: user@eeepc-johanness
In-Reply-To: <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70529>

Hi,

On Tue, 15 Jan 2008, Chris Ortman wrote:

> The format that TortoiseSVN expects is the same as the format of svn diff.
> The most apparent differences are
>
> [...]

Nothing a simple perl script cannot do.  Wanna give it a try?

Ciao,
Dscho
