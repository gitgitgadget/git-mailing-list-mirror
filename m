From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsserver: added support for update -p
Date: Wed, 10 Oct 2007 17:41:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101740400.4174@racer.site>
References: <200710101316.03633.jan@swi-prolog.org> <Pine.LNX.4.64.0710101442571.4174@racer.site>
 <200710101626.53303.jan@swi-prolog.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <jan@swi-prolog.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 18:41:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifed1-0004jn-Oe
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 18:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbXJJQlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 12:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbXJJQlV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 12:41:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:42969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754482AbXJJQlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 12:41:20 -0400
Received: (qmail invoked by alias); 10 Oct 2007 16:41:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 10 Oct 2007 18:41:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+r2CI15WqrxH239Terjaq4rBNN+3cO87dTt594II
	NFpJPqDaaQeD0d
X-X-Sender: gene099@racer.site
In-Reply-To: <200710101626.53303.jan@swi-prolog.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60519>

Hi,

On Wed, 10 Oct 2007, Jan Wielemaker wrote:

> Is there a test suite for git-cvsserver?

Yes: t/t9400-git-cvsserver-server.sh

Hth,
Dscho
