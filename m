From: Christoph Lameter <clameter@sgi.com>
Subject: Re: GIT Packages for Debian Etch
Date: Mon, 18 Jun 2007 16:18:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0706181617060.18601@schroedinger.engr.sgi.com>
References: <20070618212524.GC16393@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: carlo@alinoe.com, Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 01:19:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0QV0-0003FL-5V
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 01:19:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbXFRXSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 19:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765043AbXFRXSe
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 19:18:34 -0400
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:58900 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754992AbXFRXSd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 19:18:33 -0400
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [150.166.1.51])
	by netops-testserver-3.corp.sgi.com (Postfix) with ESMTP id 721DC90895;
	Mon, 18 Jun 2007 16:18:32 -0700 (PDT)
Received: from clameter (helo=localhost)
	by schroedinger.engr.sgi.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1I0QUS-0006Sf-00; Mon, 18 Jun 2007 16:18:32 -0700
X-X-Sender: clameter@schroedinger.engr.sgi.com
In-Reply-To: <20070618212524.GC16393@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50426>

On Mon, 18 Jun 2007, Thomas Glanzmann wrote:

> Hello,
> a friend of mine always builds the Debian Packages from unstable for
> Debian Etch. I have on all my machines the following line in
> /etc/apt/sources.list:
> 
>         deb http://rmdir.de/~michael/git/ ./
> 
> apt-get update; apt-get dist-upgrade
> 
> and you're up2speed.
> 
> If you don't trust that packages it is very easy to build them yourself:

Is there some way you can feed that into Debian please? Why the go around 
through a separate repository? The maintainer of git-core is not actively 
maintaining the package?
