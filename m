From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: SIGSEGV in merge recursive
Date: Sat, 30 Dec 2006 12:46:32 +0100
Message-ID: <87ac15txlz.fsf@mid.deneb.enyo.de>
References: <898450.11823.qm@web31804.mail.mud.yahoo.com>
	<Pine.LNX.4.63.0612301204280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 30 13:08:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0d0u-0000GC-Q4
	for gcvg-git@gmane.org; Sat, 30 Dec 2006 13:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbWL3MI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 07:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754371AbWL3MI0
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 07:08:26 -0500
Received: from mail.enyo.de ([212.9.189.167]:1374 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754362AbWL3MIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 07:08:25 -0500
X-Greylist: delayed 1305 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Dec 2006 07:08:25 EST
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1H0cff-0006nE-4p
	for git@vger.kernel.org; Sat, 30 Dec 2006 12:46:39 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63)
	(envelope-from <fw@deneb.enyo.de>)
	id 1H0cfY-0001zJ-VF
	for git@vger.kernel.org; Sat, 30 Dec 2006 12:46:32 +0100
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0612301204280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 30 Dec 2006 12:07:47 +0100
	(CET)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35617>

* Johannes Schindelin:

>> > > Failed to read a valid object file image from memory.
>> > 
>> > Who says this?
>
> Again, who says this?

It's a GDB message.
