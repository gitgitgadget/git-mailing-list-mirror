From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use the best available exec path only
Date: Sun, 11 Nov 2007 21:40:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711112140110.4362@racer.site>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
 <Pine.LNX.4.64.0711111557370.4362@racer.site>
 <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com>
 <7v3avcefg9.fsf@gitster.siamese.dyndns.org> <20071111203318.GA32671@atjola.homenet>
 <Pine.LNX.4.64.0711112047170.4362@racer.site> <20071111211732.GA11871@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 22:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrKZw-00088p-Ik
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 22:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419AbXKKVlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 16:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXKKVlD
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 16:41:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:48893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753629AbXKKVlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 16:41:00 -0500
Received: (qmail invoked by alias); 11 Nov 2007 21:40:59 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp043) with SMTP; 11 Nov 2007 22:40:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ObbdZBtBOTXJKfHptPsIzJlXX7Dt3mflNTWGbcr
	+IX+mt71xdpU+D
X-X-Sender: gene099@racer.site
In-Reply-To: <20071111211732.GA11871@atjola.homenet>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64520>

Hi,

On Sun, 11 Nov 2007, Bj?rn Steinbrink wrote:

> > In related news, IMO cmd_path should be made absolute if it is not 
> > already the case.
> 
> add_path() already takes care of that.

Yeah, and cmd_path is not used otherwise.  Sorry for the noise.

Ciao,
Dscho
