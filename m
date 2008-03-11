From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: setting git-gui locale
Date: Tue, 11 Mar 2008 11:01:25 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111100490.3873@racer.site>
References: <7vmyp7j8ui.fsf@gitster.siamese.dyndns.org>  <fr2v0s$cdb$1@ger.gmane.org> <76718490803100656k6607e00ar1cce14aedffb3b27@mail.gmail.com> <23D34F9EB30CC241B8587BC90CA4D3793FECDD268D@silik.axinom.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Maxim Fridental <fridental@axinom.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 11:02:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ1J3-0006I6-0E
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 11:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbYCKKBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 06:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbYCKKBW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 06:01:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:44110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751252AbYCKKBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 06:01:21 -0400
Received: (qmail invoked by alias); 11 Mar 2008 10:01:19 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 11 Mar 2008 11:01:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+13PAgWjK1iAtV6oph+I4DZaGojyQe3/HJ9GrskE
	a/xJrtCN/MMp+I
X-X-Sender: gene099@racer.site
In-Reply-To: <23D34F9EB30CC241B8587BC90CA4D3793FECDD268D@silik.axinom.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76828>

Hi,

On Tue, 11 Mar 2008, Maxim Fridental wrote:

> Could someone point me please to a doc describing how to override 
> language setting for git-gui tool (precompiled for Windows, downloaded 
> from http://code.google.com/p/msysgit/downloads/list)?

Try setting LANG=C or LANG=en before calling git-gui.

> It is choosing German language for its menu items on any system I 
> install it; and I personally find the German translations unusable.

Patches welcome,
Dscho
