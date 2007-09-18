From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 11:16:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181115250.28586@racer.site>
References: <20070918072627.GB3506@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXa98-0001pb-O7
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbXIRKR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbXIRKR0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:17:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:52245 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752401AbXIRKRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:17:25 -0400
Received: (qmail invoked by alias); 18 Sep 2007 10:17:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 18 Sep 2007 12:17:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ry1xqT40Rswds/t7AZAjMroGXh57MBAM8qu3lRp
	AtshffKcuZb3HJ
X-X-Sender: gene099@racer.site
In-Reply-To: <20070918072627.GB3506@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58570>

Hi,

On Tue, 18 Sep 2007, Jeff King wrote:

> This is based on the git-import.sh script, but is a little
> more robust and efficient. More importantly, it should
> serve as a quick template for interfacing fast-import with
> perl scripts.

Yes, please!  Maybe somebody will then grab the low-hanging fruit of 
writing a "git-fast-export", which can be used to dump a complete 
repository in text format?

Ciao,
Dscho
