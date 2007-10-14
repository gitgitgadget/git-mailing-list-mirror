From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Addition of "xmlto" to install documentation
Date: Sun, 14 Oct 2007 01:43:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710140143000.25221@racer.site>
References: <47112DAA.5080701@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 02:43:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igra6-0002kC-QN
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 02:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbXJNAnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 20:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbXJNAnh
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 20:43:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:46581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754016AbXJNAng (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 20:43:36 -0400
Received: (qmail invoked by alias); 14 Oct 2007 00:43:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 14 Oct 2007 02:43:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/nR41DRS/lRbCxPfhAFKF9oX+L8pARKgIGrMGp7
	ZXNhV5LkZigKO/
X-X-Sender: gene099@racer.site
In-Reply-To: <47112DAA.5080701@web.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60787>

Hi,

On Sat, 13 Oct 2007, Markus Elfring wrote:

> I have cloned the current Git release to my computer. I resolved all 
> dependencies that were mentioned in the file "INSTALL". But when I've 
> tried "make install install-doc" I got the message that "xmlto" was not 
> found on my openSUSE 10.3 system. (I have installed it now.) Would you 
> like to add this tool to the system requirements in the documentation?

Well, it is not strictly necessary to build git, and not even to install 
it, if you have the "man" branch.

Ciao,
Dscho
