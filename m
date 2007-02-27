From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unresolved issues
Date: Tue, 27 Feb 2007 21:10:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272107560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702260112160.12555@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:10:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM8eG-0003Am-0f
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbXB0UKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbXB0UKF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:10:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:55867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752526AbXB0UKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:10:04 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:10:01 -0000
X-Provags-ID: V01U2FsdGVkX1+lc/wojGWlx2OCs/urqHehNlVjkbdy2a/N1l+DA1
	d9Iw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702260112160.12555@beast.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40781>

Hi,

On Mon, 26 Feb 2007, Julian Phillips wrote:

> On Mon, 19 Feb 2007, Junio C Hamano wrote:
> 
> > * "git fetch" between repositories with hundreds of refs.
> 
> I would be happy to work on this if you would rather spend your time on 
> more generally useful things ...

I would be grateful indeed if you worked on a builtin fetch. But beware, I 
think it is quite some work...

The good thing: We have some tests involving git-fetch, so if all the 
tests pass, chances are that the builtin fetch works correctly.

(Of course, we do not have tests for HTTP, SSH and GIT fetch... Anyone?)

Ciao,
Dscho
