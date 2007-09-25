From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: My stash wants to delete all my files
Date: Tue, 25 Sep 2007 10:56:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251054440.28395@racer.site>
References: <5A9D6E3B-7B0E-4414-9AFB-C1C8B2EE6A9D@steelskies.com>
 <7vabrb8rin.fsf@gitster.siamese.dyndns.org> <DCBF8566-9B43-4EFA-A8B2-2EAB516C273F@steelskies.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 11:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia7AN-0007lc-6u
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 11:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXIYJ5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 05:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXIYJ5N
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 05:57:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:56627 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751393AbXIYJ5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 05:57:12 -0400
Received: (qmail invoked by alias); 25 Sep 2007 09:57:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 25 Sep 2007 11:57:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/fnJhTfq/vgnh71UWthS50q/r9QcaUR6Nx2bCwr
	krUqdWBruMft+Y
X-X-Sender: gene099@racer.site
In-Reply-To: <DCBF8566-9B43-4EFA-A8B2-2EAB516C273F@steelskies.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59105>

Hi,

On Tue, 25 Sep 2007, Jonathan del Strother wrote:

> I don't think I git-added anything - just made changes to the working 
> copy. (It *does* stash those, right??)

Stash does not care about things that are not tracked, so no, it does not 
stash those.  Imagine a stash saving all those .o, .a and .so files... 
Insanity!

Ciao,
Dscho
