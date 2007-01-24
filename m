From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Remote git-describe ?
Date: Wed, 24 Jan 2007 14:57:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241456230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
 <Pine.LNX.4.63.0701241201410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <38b2ab8a0701240313w64c2df57w2542b63eba2294e0@mail.gmail.com>
 <7vps94fweq.fsf@assigned-by-dhcp.cox.net> <7vlkjsfvro.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 24 14:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9idS-00073p-CC
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 14:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbXAXN5z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 08:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXAXN5z
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 08:57:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:52921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751469AbXAXN5y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 08:57:54 -0500
Received: (qmail invoked by alias); 24 Jan 2007 13:57:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 24 Jan 2007 14:57:53 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkjsfvro.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37637>

Hi,

On Wed, 24 Jan 2007, Junio C Hamano wrote:

> This should be obvious to people who know git, but the above
> does not mean we can remove gXXXX part from the describe output,
> becauses there could be infinite number of commits that are 256
> commits away from v2.6.20-rc5 tag.

This is only completely true if "infinite" is smaller than 2^160...

;-)

Ciao,
Dscho
