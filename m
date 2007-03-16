From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: cleaner/better zlib sources?
Date: Fri, 16 Mar 2007 12:34:27 +0100
Message-ID: <87zm6dl8vw.fsf@mid.deneb.enyo.de>
References: <20070316060841.19946.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 12:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSAiP-0007ay-Oq
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 12:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbXCPLfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 07:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932987AbXCPLfQ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 07:35:16 -0400
Received: from mail.enyo.de ([212.9.189.167]:1546 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932899AbXCPLfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 07:35:15 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HSAiH-0003kl-2F
	for git@vger.kernel.org; Fri, 16 Mar 2007 12:35:13 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HSAhX-0003BE-QO
	for git@vger.kernel.org; Fri, 16 Mar 2007 12:34:27 +0100
In-Reply-To: <20070316060841.19946.qmail@science.horizon.com>
	(linux@horizon.com's message of "16 Mar 2007 02:08:41 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42348>

> There's equivalent inflate code in the PGP 5.0i distribution
> (src/lib/pgp/compress/pgpZInflate.c) that's in the public domain AFAICT

It's an early fork from zlib.  gzip contains a copy, too.
