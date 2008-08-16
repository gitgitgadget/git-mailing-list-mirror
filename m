From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Aug 2008, #03; Thu, 14)
Date: Sat, 16 Aug 2008 17:33:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808161731300.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7v7iakdln7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 17:30:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUNjJ-00016h-UG
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 17:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYHPP3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 11:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYHPP3J
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 11:29:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:57940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751751AbYHPP3I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 11:29:08 -0400
Received: (qmail invoked by alias); 16 Aug 2008 15:29:04 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 16 Aug 2008 17:29:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180PEomH2806Eit0R4j/rzTj758mbj8ZihJrErZkt
	qMeCcrNOnJ1xGo
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7v7iakdln7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92550>

Hi,

On Thu, 14 Aug 2008, Junio C Hamano wrote:

> * js/checkout-dwim-local (Sat Aug 9 16:00:12 2008 +0200) 1 commit
>  + checkout --track: make up a sensible branch name if '-b' was
>    omitted
> 
> I like this low-impact usability enhancement; will most likely be in
> master soon after 1.6.0.

Pity.  I kinda hoped it would make it into 1.6.0.

The target audience of this flag are not naturally the people who update 
Git frequently, but instead only for major revisions.

Ciao,
Dscho
