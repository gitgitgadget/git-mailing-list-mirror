From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2007
Date: Tue, 27 Feb 2007 21:47:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272144580.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070225075917.GC1676@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:47:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9EV-0002GE-Eb
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbXB0Urc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbXB0Urc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:47:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:47006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751798AbXB0Urc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:47:32 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:47:30 -0000
X-Provags-ID: V01U2FsdGVkX19EaGYbqTdEmNdVCbALlXCBAZnnNxmWVCya4bwuZM
	wckw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070225075917.GC1676@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40801>

Hi,

On Sun, 25 Feb 2007, Shawn O. Pearce wrote:

> Thoughts?

The projects I would suggest are

1. Make more complete tests.
2. Use sparse to fix errors revealed by static code analysis.
3. Make more things builtin.

Regarding 2: this would be more of a sparse project IMHO. It could mean 
that sparse actually learns about fixing trivial bugs. (You need to 
inspect the result, but verifying is faster than writing.)

Ciao,
Dscho
