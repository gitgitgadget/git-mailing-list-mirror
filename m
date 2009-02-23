From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Mon, 23 Feb 2009 08:16:57 -0800
Message-ID: <20090223161657.GL22848@spearce.org>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com> <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <git@storm-olsen.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 17:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbdVn-0006HH-AI
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbZBWQQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbZBWQQ7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:16:59 -0500
Received: from george.spearce.org ([209.20.77.23]:47952 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbZBWQQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 11:16:59 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7843C38210; Mon, 23 Feb 2009 16:16:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49A2C8D1.3080104@trolltech.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111150>

Marius Storm-Olsen <marius@trolltech.com> wrote:
>
> ^shrug^ at this point you and Junio can discuss what to do, as Junio  
> already said
>
>   | "I do not understand the need for GIT_DIR! thing even
>   |  less, but since we have that there already, I do not
>   |  see a reason not to add this to the queue."
>
> And I have to agree with him. At this point, __git_ps1() is actually  
> removing useful information from the prompt; at least it does for me.

*sigh*

OK.  I guess we include it then.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
