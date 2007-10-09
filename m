From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mergetool: add support for ECMerge
Date: Tue, 9 Oct 2007 13:37:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091335580.4174@racer.site>
References: <11918785613855-git-send-email-prohaska@zib.de>
 <11918785611059-git-send-email-prohaska@zib.de> <20071008214451.GB31713@thunk.org>
 <1C50C046-3D61-4D55-8D38-B2D563C1FF2A@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:38:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfELf-0001Rz-Tz
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbXJIMh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbXJIMh6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:37:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:51338 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752217AbXJIMh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:37:57 -0400
Received: (qmail invoked by alias); 09 Oct 2007 12:37:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 09 Oct 2007 14:37:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3GyN/nmL3e+23I3lx38o54btWzc21gGBa7XNldK
	2t7lz/vtFl9m4v
X-X-Sender: gene099@racer.site
In-Reply-To: <1C50C046-3D61-4D55-8D38-B2D563C1FF2A@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60393>

Hi,

On Tue, 9 Oct 2007, Steffen Prohaska wrote:

> I work on the msysgit project and I'd like to have mergetool available 
> before I advertise git on Windows. It makes merging so much easier ;)

I would _hate_ to rely on a closed source program (in addition to Windows 
itself) in msysGit.

And it seems that you cannot even get ECMerge for free in general.

What does TortoiseCVS use?

Ciao,
Dscho
