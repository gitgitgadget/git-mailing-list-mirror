From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Functions for updating refs.
Date: Tue, 4 Sep 2007 16:33:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041632410.28586@racer.site>
References: <46DD6020.4050401@gmail.com> <Pine.LNX.4.64.0709041444070.28586@racer.site>
 <46DD6B93.10005@eudaptics.com> <Pine.LNX.4.64.0709041557590.28586@racer.site>
 <46DD7506.3090503@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:34:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISaPv-00052J-Fu
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbXIDPeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754395AbXIDPeJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:34:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:51888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753403AbXIDPeI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:34:08 -0400
Received: (qmail invoked by alias); 04 Sep 2007 15:34:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 04 Sep 2007 17:34:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YCm0dJdoYboRqxGchMpXwR8dRkPITQpycSQpZKf
	L2BS3j2QwsL3L+
X-X-Sender: gene099@racer.site
In-Reply-To: <46DD7506.3090503@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57600>

Hi,

On Tue, 4 Sep 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> 
> > Well, my idea was to let _error() print the message, and just die().
> 
> How do you avoid that die() prints an error, too?

Good point.  Colour me convinced.

Ciao,
Dscho
