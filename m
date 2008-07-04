From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Fri, 4 Jul 2008 02:33:51 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807040232200.2849@eeepc-johanness>
References: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>  <7vfxqr2won.fsf@gitster.siamese.dyndns.org>  <279b37b20807030150t2e9cbcc8wf099a5872568af8@mail.gmail.com> <56b7f5510807031127j10e33f3bl516180f7a9b5b5db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Raible <raible@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 02:34:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEZGG-0002RJ-5t
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 02:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbYGDAdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 20:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753922AbYGDAdy
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 20:33:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:57424 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753920AbYGDAdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 20:33:54 -0400
Received: (qmail invoked by alias); 04 Jul 2008 00:33:51 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp018) with SMTP; 04 Jul 2008 02:33:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KStUI2s9KYvZWyJesuXNlY4EjgFER1VPZ9nOF45
	vXBD6yQcmweIrV
X-X-Sender: user@eeepc-johanness
In-Reply-To: <56b7f5510807031127j10e33f3bl516180f7a9b5b5db@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87345>

Hi,

On Thu, 3 Jul 2008, Dana How wrote:

> I was surprised to see Dscho advocating removing this feature 
> altogether.

Why is everybody surprised when I admit mistakes?

Granted, --grep did not exist when I wrote :/ but now it does, and there 
is no good reason to keep an ill-defined construct in Git when we have 
something better.

Ciao,
Dscho
