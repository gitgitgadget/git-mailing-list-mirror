From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 23:42:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710122341160.25221@racer.site>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
 <Pine.LNX.4.64.0710112144380.4174@racer.site>
 <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
 <470FC64B.8010707@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Salikh Zakirov <salikh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 00:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgTE5-0001uw-Sn
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 00:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934027AbXJLWmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 18:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933277AbXJLWmp
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 18:42:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:40609 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934016AbXJLWmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 18:42:43 -0400
Received: (qmail invoked by alias); 12 Oct 2007 22:42:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 13 Oct 2007 00:42:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18T1wA4dAATZwpcDf13e4/ItMT+2+EISFAHXViTyK
	NggiOG/oVsvNfJ
X-X-Sender: gene099@racer.site
In-Reply-To: <470FC64B.8010707@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60708>

Hi,

On Sat, 13 Oct 2007, Salikh Zakirov wrote:

> * smudge filter is not passed a name of file being checked out, 
>   so it is not possible to exactly find the commit identifier.
>   However, this is alleviated by the fact that 'smudge' is only being run
>   for the changed files, so the last commit *is* the needed one.

No.

When changing branches, this is not the commit you think it is.

But maybe you humour me and tell me in which context such a smudge filter 
is of use.  I have yet to encounter an argument that convinces me.

Ciao,
Dscho
