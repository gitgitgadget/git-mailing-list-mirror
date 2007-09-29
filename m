From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix problem with authentification on http repository.
Date: Sun, 30 Sep 2007 00:10:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709300009580.28395@racer.site>
References: <11911047823308-git-send-email-jean.guyader@linkea.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jean Guyader <jean.guyader@gmail.com>
To: jean.guyader@linkea.org
X-From: git-owner@vger.kernel.org Sun Sep 30 01:11:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IblTN-00044W-Ti
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 01:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbXI2XLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 19:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbXI2XLj
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 19:11:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:49245 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755146AbXI2XLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 19:11:38 -0400
Received: (qmail invoked by alias); 29 Sep 2007 23:11:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 30 Sep 2007 01:11:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MXwtWp9WMQxAVZ/VDyBioac0HMPJumfEXaumZ6B
	ZXU3Dhnw6d5z2J
X-X-Sender: gene099@racer.site
In-Reply-To: <11911047823308-git-send-email-jean.guyader@linkea.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59508>

Hi,

On Sun, 30 Sep 2007, jean.guyader@linkea.org wrote:

>  git-clone.sh     |    3 ++-
>  git-fetch.sh     |    8 ++++----
>  git-ls-remote.sh |    3 ++-

git-fetch is already a builtin in "next", and -clone and -ls-remote are 
likely to follow suit.

Ciao,
Dscho
