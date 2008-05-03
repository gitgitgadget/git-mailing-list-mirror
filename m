From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Parent-less branches
Date: Sat, 3 May 2008 15:05:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805031504390.30431@racer>
References: <F26CE1A6-FE85-4AC6-BCE6-B41085A09F0F@simplicidade.org> <7vskx0wf8i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pedro Melo <melo@simplicidade.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 16:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsINi-0000m4-9w
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 16:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbYECOFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 10:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbYECOFn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 10:05:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:42676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751876AbYECOFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 10:05:42 -0400
Received: (qmail invoked by alias); 03 May 2008 14:05:40 -0000
Received: from dslb-088-067-214-063.pools.arcor-ip.net (EHLO dslb-088-067-214-063.pools.arcor-ip.net) [88.67.214.63]
  by mail.gmx.net (mp055) with SMTP; 03 May 2008 16:05:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+mHCoNo2GmzDP5b2lmofVPr6LlumBGnI2biZ5Iw1
	fOzlmxCCRyqE+6
X-X-Sender: gene099@racer
In-Reply-To: <7vskx0wf8i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81089>

Hi,

On Fri, 2 May 2008, Junio C Hamano wrote:

> Pedro Melo <melo@simplicidade.org> writes:
> 
> > inside an existing repository I want to create a new branch without a 
> > parent commit. Is there a set of commands to do this?
> 
> Typically these commits come about because you created a completely 
> separate history elsewhere in a separate repository and fetched and/or 
> pulled from there.

It is funny.  I really like that approach, but too many people seem to be 
married to the concept that you have to stay in the same working 
directory, and rather play dirty tricks with the plumbing.

Ciao,
Dscho
