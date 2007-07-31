From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add an option to specify a file to config builtin
Date: Tue, 31 Jul 2007 12:59:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707311258340.14781@racer.site>
References: <81b0412b0707310453pc6b11d2r90ca0f22b5ed601e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 13:59:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFqO6-0002dz-Cq
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 13:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXGaL7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 07:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbXGaL7k
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 07:59:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:60729 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbXGaL7j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 07:59:39 -0400
Received: (qmail invoked by alias); 31 Jul 2007 11:59:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 31 Jul 2007 13:59:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rk9Vk3NRrZ4p243WksqdRxrWGe3LpSkDCCENIwe
	nbqmWNT193AS2Q
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0707310453pc6b11d2r90ca0f22b5ed601e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54340>

Hi,

On Tue, 31 Jul 2007, Alex Riesen wrote:

> There are (really!) systems where using environment variables is very
> cumbersome (yes, Windows, it has problems unsetting them). Besides this
> form is shorter.

You could use this chance to make the verse nicer, i.e. split it into a 
[<file-option>] and an [<action>] part.

Ciao,
Dscho
