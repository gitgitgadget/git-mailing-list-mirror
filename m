From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2 1/2] Support multiple virtual repositories with a single
 object store and refs
Date: Thu, 26 May 2011 01:56:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1105260154440.2701@bonsai2>
References: <1306274066-4092-1-git-send-email-jamey@minilop.net> <7v7h9f7kzx.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1105250847380.2701@bonsai2> <20110525154405.GA4839@oh.minilop.net> <7vipsy36sb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 01:56:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNw2-000109-6b
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab1EYX4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 19:56:13 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:58296 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752840Ab1EYX4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:56:12 -0400
Received: (qmail invoked by alias); 25 May 2011 23:56:10 -0000
Received: from pD9EB28BC.dip0.t-ipconnect.de (EHLO noname) [217.235.40.188]
  by mail.gmx.net (mp005) with SMTP; 26 May 2011 01:56:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZY/w3QRVZN+mPZnBRO8WAQEV/9FBTvz1azj493o
	D5iS2HoIcLBs+X
X-X-Sender: gene099@bonsai2
In-Reply-To: <7vipsy36sb.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174483>

Dear Junio,

On Wed, 25 May 2011, Junio C Hamano wrote:

> Jamey Sharp <jamey@minilop.net> writes:
> 
> >> I had to read the example call to understand that 'virtual 
> >> repository' means 'one real catch-em-all repository'.
> >> 
> >> I wonder about two things, though:
> >> 
> >> 1) Would teaching git clone to understand "-t this/repo/*" help?
> >
> > Sure, that would be an improvement for our use case,...
> 
> Hmm, what does the "-t" option do?

Well, I assumed that "git clone" would have adopted "git remote add"s -t 
option in the meantime.

Hth,
Johannes
