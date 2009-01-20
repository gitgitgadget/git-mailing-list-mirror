From: jidanni@jidanni.org
Subject: Re: [PATCH,v4] git-checkout(1): mention fate of extraneous files
Date: Wed, 21 Jan 2009 03:45:15 +0800
Message-ID: <87zlhl69tg.fsf@jidanni.org>
References: <7vy6x6odiw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bss@iguanasuicide.net, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 20 20:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPMYe-0008LH-2s
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 20:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381AbZATTpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 14:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753292AbZATTpT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 14:45:19 -0500
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:39878 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753277AbZATTpS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 14:45:18 -0500
Received: from jidanni.org (122-127-33-220.dynamic.hinet.net [122.127.33.220])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a6.g.dreamhost.com (Postfix) with ESMTP id 7354F1546B;
	Tue, 20 Jan 2009 11:45:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106511>

Thank you all for your responses. I hope one day the git-checkout man
page will document what git-checkout does.

I believe that when classified in terms of their differing fates,
there are two or three different types of files that might be sitting
around in one's working tree at the time a "git checkout comes down on
their heads".

Perhaps a brief table of their different fates might nice to have on
the bottom of the man page.

OK, never mind.
