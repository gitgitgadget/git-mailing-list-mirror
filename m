From: jidanni@jidanni.org
Subject: Re: [PATCH,v2] git-bundle(1): add no references required simplest case
Date: Wed, 04 Feb 2009 08:09:02 +0800
Message-ID: <87y6wnnjvl.fsf@jidanni.org>
References: <7vab95r7j4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: johannes.schindelin@gmx.de, mdl123@verizon.net,
	spearce@spearce.org, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 04 01:10:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUVLe-0003e5-Nr
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 01:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbZBDAJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 19:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbZBDAJH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 19:09:07 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:47275 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750905AbZBDAJG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2009 19:09:06 -0500
Received: from jidanni.org (122-127-36-141.dynamic.hinet.net [122.127.36.141])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id A95FC41520;
	Tue,  3 Feb 2009 16:09:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108279>

Junio, could you combine your two recent versions,
http://news.gmane.org/group/gmane.comp.version-control.git/thread=103575/force_load=t/focus=108030
into a final one and commit it. No need to credit me. This is already
way over my head.  Note however that the git clone example disappeared
from your final version. Also perhaps give a simplest example of git
pull. Indeed, much of your discussion is valuable and should be
included on the man page. Whatever you commit is fine. I would just
like to "close this bug" without having all the valuable documentation
you wrote for it just go down the drain, which will certainly happen
if I didn't send this message...
