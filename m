From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Any way to edit the file in index directly?
Date: Wed, 8 Apr 2009 07:44:02 +0200
Message-ID: <200904080744.02580.markus.heidelberg@web.de>
References: <46dff0320904071803k68fddff4j226760392e0c5bcc@mail.gmail.com> <20090408021620.GC18244@coredump.intra.peff.net> <46dff0320904071927l16d54c8bv9c219e681cc96bb2@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 07:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrQc3-00028M-0n
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 07:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757609AbZDHFoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 01:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758165AbZDHFoJ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 01:44:09 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57689 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757609AbZDHFoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 01:44:08 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id CAAFDFF8FDB3;
	Wed,  8 Apr 2009 07:43:42 +0200 (CEST)
Received: from [89.59.73.185] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LrQZa-0005X3-00; Wed, 08 Apr 2009 07:43:42 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <46dff0320904071927l16d54c8bv9c219e681cc96bb2@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18VRSo/tYqWQlhOSyePcIDWErkiM+wETYEQlC4A
	MqT+9J9lq+xrBjozA+YUNwefbr1en2rvinO/jQj0GnIM/NHIzL
	Ijuzf/oPsalRTgWijOPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116038>

Ping Yin, 08.04.2009:
> On Wed, Apr 8, 2009 at 10:16 AM, Jeff King <peff@peff.net> wrote:
> > I'm not sure what you mean by "alongside".
> 
> By "aloneside" i mean i can open the index and worktree file in diff
> mode side by side for easily editing.

This is possible with git-difftool from the contrib/ area, but without
editing the index file.
But I think "worktree" is called "worktree" for a good reason.

Markus
