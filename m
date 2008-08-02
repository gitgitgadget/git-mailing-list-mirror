From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui translators - please update translations if necessary
Date: Sat, 2 Aug 2008 14:49:30 -0700
Message-ID: <20080802214930.GA25311@spearce.org>
References: <20080802211714.GG24723@spearce.org> <7vod4bccx8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOzh-0002zA-4k
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYHBVtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbYHBVtb
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:49:31 -0400
Received: from george.spearce.org ([209.20.77.23]:36849 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYHBVta (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:49:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 457C538419; Sat,  2 Aug 2008 21:49:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vod4bccx8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91189>

Junio C Hamano <gitster@pobox.com> wrote:
>
> Grepping po/*.po and po/git-gui.pot for POT-Creation-Date reveals that
> po/de.msg is much more recent than po/git-gui.pot and all others are
> translating the same POT.
> 
> Perhaps you wanted to update git-gui.pot first before sending this request
> out?

Oh.  Its updated now, but msgmerge on my system is busted and won't
update the po files themselves.  *sigh*

-- 
Shawn.
