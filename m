From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] git-tag: Document that -m/-F create tag objects, too
Date: Mon, 09 Apr 2007 17:31:01 +0200
Message-ID: <87y7l11s5m.fsf@mid.deneb.enyo.de>
References: <E1Hash0-0004rN-Mu@mid.deneb.enyo.de>
	<Pine.LNX.4.64.0704091554330.32490@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Apr 09 18:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Havpt-0001uo-2v
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 17:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbXDIPbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 11:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbXDIPbG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 11:31:06 -0400
Received: from mail.enyo.de ([212.9.189.167]:1085 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbXDIPbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 11:31:05 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Havpf-0007UG-88; Mon, 09 Apr 2007 17:31:03 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.63)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Havpd-0006QN-Iu; Mon, 09 Apr 2007 17:31:01 +0200
In-Reply-To: <Pine.LNX.4.64.0704091554330.32490@beast.quantumfyre.co.uk>
	(Julian Phillips's message of "Mon, 9 Apr 2007 15:58:31 +0100 (BST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44056>

* Julian Phillips:

> On Mon, 9 Apr 2007, Florian Weimer wrote:
>
>> And warn about the fact that lightweight tags are not normally
>> transferred by clone/fetch.
>
> Um ... yes, they are (in v1.5.1 at least).

Hmm.  This has to be a fairly recent change, see:

<http://article.gmane.org/gmane.linux.kernel/513438>
