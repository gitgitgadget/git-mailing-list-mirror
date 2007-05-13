From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Fix assorted white space damage
Date: Sun, 13 May 2007 12:31:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705131230230.6410@racer.site>
References: <e5bfff550705120409v629425aesc910927c26871323@mail.gmail.com>
 <7vzm49ts2f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 12:31:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnBLx-00065k-Jm
	for gcvg-git@gmane.org; Sun, 13 May 2007 12:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259AbXEMKaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 06:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757276AbXEMKaz
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 06:30:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:55344 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757259AbXEMKay (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 06:30:54 -0400
Received: (qmail invoked by alias); 13 May 2007 10:30:51 -0000
Received: from R4457.r.pppool.de (EHLO noname) [89.54.68.87]
  by mail.gmx.net (mp044) with SMTP; 13 May 2007 12:30:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WbW44tp4WneLnMIk5tNw6dKf503Tukzpe4ZQRr/
	vFMqLpRGqjrERD
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm49ts2f.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47136>

Hi,

On Sat, 12 May 2007, Junio C Hamano wrote:

> In the above I explicitly "saved" t/ because we have some test vectors 
> that need to have trailing whitespaces.

AFAICT the documentation has trailing whitespace also, to indicate that 
the paragraph does not end here. Correct me if I'm wrong, and these 
trailing whitespaces are not necessary.

Ciao,
Dscho
