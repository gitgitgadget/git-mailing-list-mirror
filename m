From: Raimund Bauer <ray007@gmx.net>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Tue, 11 Nov 2008 11:06:40 +0100
Message-ID: <1226398000.7541.11.camel@minastirith.xtradesoft.lan>
References: <200811101522.13558.fg@one2team.net>
	 <7v63mv5mro.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Francis Galiegue <fg@one2team.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 11:08:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzqAC-0005Ia-G1
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 11:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbYKKKGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 05:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbYKKKGp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 05:06:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:58461 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752852AbYKKKGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 05:06:44 -0500
Received: (qmail invoked by alias); 11 Nov 2008 10:06:42 -0000
Received: from unknown (EHLO [192.168.1.100]) [213.185.179.42]
  by mail.gmx.net (mp003) with SMTP; 11 Nov 2008 11:06:42 +0100
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1/aNEJ6OfDagDebebjlLNm5WpAXgSnvDz1MIMEtp9
	4FP2y6y+jX6f5M
In-Reply-To: <7v63mv5mro.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.1 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100634>


On Mon, 2008-11-10 at 12:50 -0800, Junio C Hamano wrote:
> Francis Galiegue <fg@one2team.net> writes:
> 
> > A very nice git feature, without even going as far as merges, is the cherry 
> > pick feature.
> 
> I thought cherry-picking needs to be done in terms of 3-way merge, not
> diff piped to patch, for correctness's sake.

What about http://sourceforge.net/projects/jlibdiff ?
Maybe a bit old, but claims to have diff3 and is under LGPL.

best regards,
Ray
