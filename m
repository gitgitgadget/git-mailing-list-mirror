From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/6] Restructure git-merge.sh
Date: Thu, 22 May 2008 11:48:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805221147550.30431@racer>
References: <1211419009-9741-1-git-send-email-gitster@pobox.com> <1211419009-9741-2-git-send-email-gitster@pobox.com> <1211419009-9741-3-git-send-email-gitster@pobox.com> <1211419009-9741-4-git-send-email-gitster@pobox.com>
 <1211419009-9741-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 12:50:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz8Mh-0008RB-7G
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 12:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbYEVKsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 06:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbYEVKsb
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 06:48:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:40712 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750696AbYEVKsb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 06:48:31 -0400
Received: (qmail invoked by alias); 22 May 2008 10:48:29 -0000
Received: from R5e98.r.pppool.de (EHLO racer.local) [89.54.94.152]
  by mail.gmx.net (mp008) with SMTP; 22 May 2008 12:48:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ek5pJQCceK9AO95mO/AtreMY5nRLjYTzdJonkn3
	ZVkW3xCw3/SfDN
X-X-Sender: gene099@racer
In-Reply-To: <1211419009-9741-5-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82612>

Hi,

On Wed, 21 May 2008, Junio C Hamano wrote:

> From: Sverre Hvammen Johansen <hvammen@gmail.com>
> 
> Restructure git-merge.sh for preparation of new feature:
> 
>        Head reduction before selecting merge strategy
> 
> Some aspects of this patch does not make much sense without
> the next patch in this series.

As my student is pretty busy rewriting git-merge into a C builtin, can I 
ask to hold this patch off?

Thanks,
Dscho
