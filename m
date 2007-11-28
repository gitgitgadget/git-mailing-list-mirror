From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export
 VAR
Date: Wed, 28 Nov 2007 23:08:32 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282307360.27959@racer.site>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
 <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
 <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
 <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net>
 <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com> <Pine.LNX.4.64.0711261340470.27959@racer.site>
 <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com> <7vir3m94ku.fsf@gitster.siamese.dyndns.org>
 <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com> <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
 <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com> <Pine.LNX.4.64.0711281355460.27959@racer.site>
 <474D7956.8050401@viscovery.net> <Pine.LNX.4.64.0711281428180.27959@racer.site>
 <474D7D92.2000106@viscovery.net> <7vr6ia5hoi.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711281903330.27959@racer.site> <7vve7m2dhs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:09:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxW1f-0006HD-6a
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686AbXK1XIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755590AbXK1XIo
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:08:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:39055 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755340AbXK1XIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:08:43 -0500
Received: (qmail invoked by alias); 28 Nov 2007 23:08:41 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp054) with SMTP; 29 Nov 2007 00:08:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eFr9m7DeebrbYksIIaxNnmUhQV0O7v4UoFQ4gQt
	1DiYq+GxmDL1GO
X-X-Sender: gene099@racer.site
In-Reply-To: <7vve7m2dhs.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66457>

Hi,

On Wed, 28 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Is there a particular reason to force linebreak when a semicolon would
> >> do?
> >
> > D'oh.  Of course.  You want me to resend?
> 
> Semicolon I can handle but you seem to have local changes to filter
> branch.

Only that patch to de-uglify the functions in the commit filter that I 
sent out earlier.

Ciao,
Dscho
