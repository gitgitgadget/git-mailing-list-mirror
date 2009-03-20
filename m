From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH RESEND] git-gui: Fix merge conflict display error when filename contains spaces
Date: Fri, 20 Mar 2009 21:11:55 +0100
Message-ID: <200903202111.56090.markus.heidelberg@web.de>
References: <49C34B5A.2040807@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkl5n-0002DL-H1
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 21:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbZCTULu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 16:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbZCTULu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 16:11:50 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:34911 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbZCTULt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 16:11:49 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 8A30AFBDFCD1
	for <git@vger.kernel.org>; Fri, 20 Mar 2009 21:11:47 +0100 (CET)
Received: from [89.59.113.155] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lkl4E-0005v5-00; Fri, 20 Mar 2009 21:11:46 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <49C34B5A.2040807@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/JhyVCcGFyyzzdqcgTzmc2hnwELnFAh06rZwIo
	RDpVi5km2+xY6gwhD8eUK60z/TZ7iCjh6RkNqJ6/ZFvry3pmeD
	52+9KosHM1nYXr8kjrew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114000>

Jens Lehmann, 20.03.2009:
> When a merge conflict occurs in a file with spaces in the filename,
> git-gui showed wrongly "LOCAL: deleted".
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
> 
> Resending this patch, as i have not received any reply so far.

You should send git-gui patches to Shawn O. Pearce <spearce@spearce.org>,
since he is the maintainer, and CCing the git list.
This will raise the chance of a reply. Or maybe it will simply be
commited to http://repo.or.cz/w/git-gui.git without a reply.

Markus
