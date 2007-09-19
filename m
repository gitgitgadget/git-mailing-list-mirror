From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] instaweb: added support Ruby's WEBrick server
Date: Wed, 19 Sep 2007 02:27:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709190225550.28395@racer.site>
References: <20070918121634.E8EFF814635@cyrano> <7vodfztviv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mike dalessio <mike@csa.net>, git@vger.kernel.org,
	normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 03:28:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXoMT-000376-IP
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 03:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbXISB2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 21:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbXISB2K
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 21:28:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:46260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750814AbXISB2J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 21:28:09 -0400
Received: (qmail invoked by alias); 19 Sep 2007 01:28:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 19 Sep 2007 03:28:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GC00Rct6GC3mlrMl7L4JSuMl68oe8WHGQD2BWz/
	1R52GA0Cl3M/JK
X-X-Sender: gene099@racer.site
In-Reply-To: <7vodfztviv.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58673>

Hi,

On Tue, 18 Sep 2007, Junio C Hamano wrote:

> I wonder how popular instaweb is and how widely it is used. I've 
> actually wondering if we should demote it to contrib/ somewhere, but it 
> gets occasional updates so people must be using it...

I have to admit that I found it easier to install gitweb manually, 
especially with recent documentation enhancements, _and_ the constraint 
that I had to use an existing DocumentRoot.

So I would not be opposed to move this into contrib/.

Ciao,
Dscho
