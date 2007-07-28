From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: suggestion for git rebase -i
Date: Sat, 28 Jul 2007 21:09:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707282109090.14781@racer.site>
References: <m26445t98z.fsf@ziti.fhcrc.org> <Pine.LNX.4.64.0707280941380.14781@racer.site>
 <m2vec4seyf.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Seth Falcon <sfalcon@fhcrc.org>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:10:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEsc3-0001gS-RU
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 22:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbXG1UKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 16:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXG1UKE
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 16:10:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:41861 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753794AbXG1UKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 16:10:03 -0400
Received: (qmail invoked by alias); 28 Jul 2007 20:10:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 28 Jul 2007 22:10:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197jltfDHp7jjmNQoBbuhFYwQItnDpeMvxmoWi8A/
	58+rd/9QYOpNBq
X-X-Sender: gene099@racer.site
In-Reply-To: <m2vec4seyf.fsf@ziti.fhcrc.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54057>

Hi,

On Sat, 28 Jul 2007, Seth Falcon wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > Why?  This is an implementation detail, and should not concern the
> > user.
> 
> In the context of an existing editing session, the name of the tempfile 
> is visible and relevant to the user (not just an implementation detail).  
> For example, the tempfile name is useful when multi-tasking and one 
> needs to get back to the buffer.  As another reply pointed out, the name 
> could also be used for editor mode customization.

Okay, fair enough.  But since you want that feature, you get to do the 
patch.  Hint: it is just one line that has to be changed.

Ciao,
Dscho
