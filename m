From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-remote: do not complain on multiple URLs for a
 remote
Date: Wed, 27 Feb 2008 22:19:58 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802272219120.22527@racer.site>
References: <7v3arerrn1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 23:21:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUUeE-0007s4-MP
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:21:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758358AbYB0WUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 17:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758298AbYB0WUd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:20:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:47272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756693AbYB0WUc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 17:20:32 -0500
Received: (qmail invoked by alias); 27 Feb 2008 22:20:30 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp030) with SMTP; 27 Feb 2008 23:20:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198xPx7Zdp8KBPaqZDlhdBwzq9o2ldpgPhbFzXFf9
	dYnWa2HQHwgk8T
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3arerrn1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75310>

Hi,

On Wed, 27 Feb 2008, Junio C Hamano wrote:

> +		if (! exists $hash->{'URL'}) {

Is it preferred style now to add a space after "!"?

BTW I take this patch as a hint that I should resurrect builtin-remote...

Thanks,
Dscho
