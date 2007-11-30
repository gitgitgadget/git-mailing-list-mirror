From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run without sub-commands
Date: Fri, 30 Nov 2007 09:41:31 +0100
Organization: glandium.org
Message-ID: <20071130084131.GA29668@glandium.org>
References: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@bluebottle.com>
To: Kevin Leung <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 09:42:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy1SK-0002pg-Iv
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 09:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759050AbXK3ImU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 03:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758979AbXK3ImU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 03:42:20 -0500
Received: from vuizook.err.no ([85.19.215.103]:33843 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758357AbXK3ImT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 03:42:19 -0500
Received: from aputeaux-153-1-85-180.w86-205.abo.wanadoo.fr ([86.205.43.180] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1Iy1S9-0008TY-NA; Fri, 30 Nov 2007 09:42:35 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1Iy1RD-0007k1-V3; Fri, 30 Nov 2007 09:41:31 +0100
Content-Disposition: inline
In-Reply-To: <e66701d40711300016v15700deft3d262d75a9055aca@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66625>

On Fri, Nov 30, 2007 at 04:16:34PM +0800, Kevin Leung <kevinlsk@gmail.com> wrote:
> The current git-stash behaviour is very error prone to typos. For example,
> if you typed "git-stash llist", git-stash would thought that you wanted to
> save to a stash named "llist", but in fact, you meant "git-stash list".

Still, 'git stash' alone should *do* the stash.

Mike
