From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git clone questions relating to cpio
Date: Tue, 2 Oct 2007 00:23:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710020022470.28395@racer.site>
References: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 01:25:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcUde-0000hr-47
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 01:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbXJAXZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 19:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbXJAXZO
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 19:25:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:38461 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751787AbXJAXZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 19:25:13 -0400
Received: (qmail invoked by alias); 01 Oct 2007 23:25:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 02 Oct 2007 01:25:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sB3QrLRzsW0TZTXFhveW0N4nhZaSsSjTUXljbeF
	TxwJT+x0S5Rp5E
X-X-Sender: gene099@racer.site
In-Reply-To: <3f4fd2640710011228w61ce34b5ve47ea529eed384fd@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59649>

Hi,

On Mon, 1 Oct 2007, Reece Dunn wrote:

> I am running a Linux From Scratch 6.2 system that does not have cpio
> installed on it. This means that I can't clone a local repository
> unless I install cpio.

You might be interested in the workaround Hannes did in mingw.git; he made 
a wrapper script called 'cpio' using 'tar'.

Ciao,
Dscho
