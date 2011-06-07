From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Document the underlying protocol used by shallow
 repositories and --depth commands.
Date: Wed, 8 Jun 2011 01:06:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1106080102190.2918@bonsai2>
References: <loom.20110607T212226-56@post.gmane.org> <7vzklt4c92.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Neronskiy <zakmagnus@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:06:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5MR-0006yf-07
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678Ab1FGXGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:06:54 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:37800 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932675Ab1FGXGx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:06:53 -0400
Received: (qmail invoked by alias); 07 Jun 2011 23:06:52 -0000
Received: from 3-254.197-178.cust.bluewin.ch (EHLO bonsai2.local) [178.197.254.3]
  by mail.gmx.net (mp048) with SMTP; 08 Jun 2011 01:06:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18unuZzW7suggDMfCnTG/nJIcJXvV4nWeYoAMrM4c
	lzjOOAJugUWoi9
X-X-Sender: gene099@bonsai2
In-Reply-To: <7vzklt4c92.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175286>

Dear Junio,

On Tue, 7 Jun 2011, Junio C Hamano wrote:

> Alex Neronskiy <zakmagnus@google.com> writes:
> 
> By the way, Dscho, the shallow extension was your invention 4 and half
> years ago.

Yep, I remember. My iBook died in the process. But I got the job.

> I think the description in this version is mostly accurate (modulo the 
> part that talks about an early client termination after "shallow" and 
> "deepen" are sent), but I'd appreciate if you can comment on it to 
> improve.

I will, once I am back to normal after traveling. Unfortunately (for my 
Git contributions at least), I will be heavily traveling in the next time, 
maybe for the next two years. But as for the patch you requested my 
look-over, I expect to have enough time tomorrow, latest coming weekend.

Ciao,
Johannes
