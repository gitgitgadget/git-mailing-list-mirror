From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Segmentation fault on http clone, post-1.5.6
Date: Tue, 24 Jun 2008 23:56:00 +0200
Message-ID: <20080624215600.GJ8421@neumann>
References: <20080624130457.GB13696@mithlond.arda.local>
	<20080624164034.GB4654@sigill.intra.peff.net>
	<20080624185723.GA3368@mithlond.arda.local>
	<alpine.LFD.1.10.0806241524480.2979@xanadu.home>
	<20080624205556.GA3565@mithlond.arda.local>
	<alpine.LFD.1.10.0806241720440.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Teemu Likonen <tlikonen@iki.fi>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 23:57:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBGWI-0001uV-9q
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 23:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610AbYFXV43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 17:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756581AbYFXV4J
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 17:56:09 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56809 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbYFXV4C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 17:56:02 -0400
Received: from [127.0.1.1] (p5B133023.dip0.t-ipconnect.de [91.19.48.35])
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis)
	id 0ML25U-1KBGUa0AtT-0000l4; Tue, 24 Jun 2008 23:56:00 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806241720440.2979@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+3uZEp97R6OI9iJCX6Ym+DZceXUKPl85C+dIe
 5i+P1wzrRPptuZ7YHR+sP7lF4sQz18qA9gQYLL2+WUbvAcoeVc
 g5Tn4f4MgbGNOb6ekORUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86154>

Hi,

On Tue, Jun 24, 2008 at 05:24:49PM -0400, Nicolas Pitre wrote:
> The problem is probably fixed with this:
>=20
> Could you confirm it?
It seems to fix the problem at me.

G=E1bor
