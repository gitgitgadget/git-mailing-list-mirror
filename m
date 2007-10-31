From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 02:28:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710310227340.4362@racer.site>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
 <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
 <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:29:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In3Ky-0001fK-3I
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 03:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbXJaC3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 22:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbXJaC3a
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 22:29:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:50341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752287AbXJaC33 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 22:29:29 -0400
Received: (qmail invoked by alias); 31 Oct 2007 02:29:28 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp001) with SMTP; 31 Oct 2007 03:29:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ns3xgB3Bnz7D0rg4OtnPnkAuE3RcrAr6azvPbhS
	PJWxCGrbuaKfeF
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62784>

Hi,

On Tue, 30 Oct 2007, Peter Karlsson wrote:

> Lars Hjemli:
> 
> > No, the grafts file is purely local.
> 
> Hmm, any chance that will change in a future version?

Why should it?  This would contradict the whole "a commit sha1 hashes the 
commit, and by inference the _whole_ history" principle.

Ciao,
Dscho
