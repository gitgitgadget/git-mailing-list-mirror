From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-show ignores --pretty
Date: Tue, 16 Jan 2007 12:32:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701161231460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701161058.15725.andyparkins@gmail.com>
 <200701161114.07073.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 12:32:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6mYQ-0002nP-BU
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 12:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbXAPLcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 06:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXAPLcf
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 06:32:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:46708 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750749AbXAPLcf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 06:32:35 -0500
Received: (qmail invoked by alias); 16 Jan 2007 11:32:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 16 Jan 2007 12:32:33 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701161114.07073.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36932>

Hi,

On Tue, 16 Jan 2007, Andy Parkins wrote:

> You always get the diff, which could well be intended.  Is that the 
> case?  If it is, is there a way to surpress the diff?

"git show -s <commit>"

Ciao,
Dscho
