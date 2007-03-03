From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Problems with git cvsimport
Date: Sat, 3 Mar 2007 17:21:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703031720290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <000c01c75b3c$31f91000$0b0aa8c0@abf.local> 
 <Pine.LNX.4.63.0703030129220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <1172925097.11109.25.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Raimund Bauer <ray007@gmx.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 17:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNWzW-0001st-VL
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 17:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030678AbXCCQVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 11:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030679AbXCCQVi
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 11:21:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:43304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030678AbXCCQVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 11:21:37 -0500
Received: (qmail invoked by alias); 03 Mar 2007 16:21:36 -0000
X-Provags-ID: V01U2FsdGVkX19slVksr21sDXiCdPKPxUjuYnDjeAhHNWMPNHHuA8
	PRf+L63GFHFjAn
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1172925097.11109.25.camel@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41303>

Hi,

On Sat, 3 Mar 2007, Raimund Bauer wrote:

> I've just tried it out on my home-box, which is a ubuntu edgy x86 
> installation, and git-cvsimport seems to work quite fine here.
> 
> On our server, which is a suse 9.3 amd64 installation (with the latest 
> suse updates for that version), I just can't get it to run. Currently I 
> wonder how I got _any_ git-cvsimport to work there. Still the same error 
> 256 ...
> 
> How do I find out the minimum-version of tools I need to use
> git-cvsimport? I already know about cvsps and did install a current
> version there, but there seem to be some more dependencies ...
> Or could it be a 64-bit issue somewhere?

It could be. I'd first try cvsps itself, to find out if the issue is not 
there (not many 64-bit issues in Perl, are there?).

Hth,
Dscho
