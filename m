From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Sending a thread of patches
Date: Mon, 5 Mar 2007 03:25:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703050324220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45EB4F98.7030206@issaris.org> <Pine.LNX.4.64.0703042354250.15433@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Panagiotis Issaris <takis@issaris.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 05 03:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO2tA-0004NS-7c
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 03:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbXCECZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 21:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbXCECZU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 21:25:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:42081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752560AbXCECZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 21:25:18 -0500
Received: (qmail invoked by alias); 05 Mar 2007 02:25:17 -0000
X-Provags-ID: V01U2FsdGVkX18JoAUjkOIJ0Ck8/JAwu6KHRmx3/obzc+PaBiHWPc
	HhQuoLqL3J+A3+
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703042354250.15433@beast.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41395>

Hi,

On Sun, 4 Mar 2007, Julian Phillips wrote:

> As far as I can figure, you don't want to use the --thread option to 
> git-format-patch when using git-send-email.

That might be true. However, I consider it a bug when git-send-email does 
not replace the In-Reply-To: header, but adds a second one.

Ciao,
Dscho
