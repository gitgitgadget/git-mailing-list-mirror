From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git proxy issue
Date: Wed, 25 Jul 2007 00:07:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707250006530.14781@racer.site>
References: <6d6a94c50707151921h7f2a65fes65c94c3c1090937a@mail.gmail.com> 
 <7vk5t1avcn.fsf@assigned-by-dhcp.cox.net> <6d6a94c50707152055m4a8e24b8v7dc90101316e6b88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Aubrey Li <aubreylee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:07:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDTTo-0006Vf-1f
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 01:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbXGXXHp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 19:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbXGXXHp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 19:07:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:58076 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753352AbXGXXHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 19:07:44 -0400
Received: (qmail invoked by alias); 24 Jul 2007 23:07:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 25 Jul 2007 01:07:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cmSg8tZmccQH7TcRyI3c0qZ72UyBjpwoLUGFtg9
	YrVIrfLc7oMT8k
X-X-Sender: gene099@racer.site
In-Reply-To: <6d6a94c50707152055m4a8e24b8v7dc90101316e6b88@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53656>

Hi,

On Mon, 16 Jul 2007, Aubrey Li wrote:

> On 7/16/07, Junio C Hamano <gitster@pobox.com> wrote:
> > "Aubrey Li" <aubreylee@gmail.com> writes:
> > 
> > > From which release version git proxy is supported?
> > 
> > v0.99.9k (Nov 25 2005) is the first tagged release (the patch
> > itself was from Nov 4 2005).
> > 
> > 
> oh, so how to config it?

Look into Documentation/git-config.txt.  (Or "man git-config", if the man 
pages are installed.)

Ciao,
Dscho
