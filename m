From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rev-parse doesn't take pwd into consideration
Date: Mon, 26 May 2008 22:42:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805262239060.30431@racer>
References: <20080526195812.GA23396@bit.office.eurotux.com> <7vhcckddov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luciano Rocha <luciano@eurotux.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 26 23:43:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0kTK-0002zK-Cx
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 23:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbYEZVmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 17:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbYEZVmX
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 17:42:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:39171 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754904AbYEZVmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 17:42:22 -0400
Received: (qmail invoked by alias); 26 May 2008 21:42:20 -0000
Received: from R105f.r.pppool.de (EHLO racer.local) [89.54.16.95]
  by mail.gmx.net (mp040) with SMTP; 26 May 2008 23:42:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/63IQty0L6APBcI/Dv0OA6zUzX8gnAFFw1OaVYDi
	3XHiZGX12ELqKH
X-X-Sender: gene099@racer
In-Reply-To: <7vhcckddov.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82961>

Hi,

On Mon, 26 May 2008, Junio C Hamano wrote:

> This was discussed to death.  Check the list archive.

FWIW I have a patch in my personal fork that allows "git show HEAD:./bla":

http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=3007b5c53d9b571f992f3e2d801248ff0bd15c76

If you like the patch, you are free to push for inclusion; I do not need 
it myself, and wasted enough time in writing it, so I will not waste any 
more time with it.

Ciao,
Dscho
