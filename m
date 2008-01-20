From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Time to flush developer accumulated patches?
Date: Sun, 20 Jan 2008 13:49:15 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801201347040.5731@racer.site>
References: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 14:50:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGaYh-0007pn-Md
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 14:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbYATNta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 08:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYATNta
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 08:49:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:44132 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753326AbYATNt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 08:49:29 -0500
Received: (qmail invoked by alias); 20 Jan 2008 13:49:27 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 20 Jan 2008 14:49:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/uR0Tslk/sRgIl6AYBfd+kmqWNLL9NlmYnNEttt
	8M/gVRRBdILJqA
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71175>

Hi,

On Sun, 20 Jan 2008, Marco Costalba wrote:

> Reading mailing list threads it is becoming common these days to hear 
> about contributors with patches ready to be sent as soon as 1.5.4 is 
> out.

Which is good.

> Would be a good idea to open a new branch new_stuff as a target for this 
> pending stuff?

No.  The purpose of the rc cycle is to _stabilise_ things, which means 
that people should _focus_ on stabilising things.

If you give them enough to play with, they just get sidetracked, and the 
stabilisation is left to... Junio.  Which is not only hard on our good 
maintainer, but outright mean.

Ciao,
Dscho
