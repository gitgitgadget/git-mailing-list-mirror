From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: sbuild (or whatever) integration
Date: Tue, 29 May 2007 11:26:41 +0200
Message-ID: <87ps4kasku.fsf@mid.deneb.enyo.de>
References: <87sl9t6jhr.fsf@mid.deneb.enyo.de>
	<20070521181505.GA5082@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 29 11:27:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsxz1-0003P2-Lw
	for gcvg-git@gmane.org; Tue, 29 May 2007 11:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbXE2J0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 05:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXE2J0p
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 05:26:45 -0400
Received: from mail.enyo.de ([212.9.189.167]:3445 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbXE2J0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 05:26:44 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HsxyU-00042x-Ri; Tue, 29 May 2007 11:26:43 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HsxyT-0002Kc-Ae; Tue, 29 May 2007 11:26:41 +0200
In-Reply-To: <20070521181505.GA5082@efreet.light.src> (Jan Hudec's message of
	"Mon, 21 May 2007 20:15:05 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48676>

* Jan Hudec:

> IMHO generic tools won't help you much, because every other command is Debian
> specific.

Yeah, and I mainly wanted to reuse process, not code.  Thanks for your
comments.
