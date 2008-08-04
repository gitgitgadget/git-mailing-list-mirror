From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui translators - please update translations if necessary
Date: Mon, 4 Aug 2008 07:50:46 -0700
Message-ID: <20080804145046.GC27666@spearce.org>
References: <20080802211714.GG24723@spearce.org> <7vod4bccx8.fsf@gitster.siamese.dyndns.org> <20080802214930.GA25311@spearce.org> <Pine.LNX.4.64.0808041215140.4744@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1Pa-0007KH-BI
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbYHDOur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbYHDOur
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:50:47 -0400
Received: from george.spearce.org ([209.20.77.23]:38613 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbYHDOur (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:50:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7B76B38419; Mon,  4 Aug 2008 14:50:46 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0808041215140.4744@ds9.cixit.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91364>

Peter Krefting <peter@softwolves.pp.se> wrote:
> Shawn O. Pearce:
> 
> > > Perhaps you wanted to update git-gui.pot first before sending this request
> > > out?
> 
> > Oh.  Its updated now, but msgmerge on my system is busted and won't
> > update the po files themselves.  *sigh*
> 
> In that case I would recommend submitting the translation to
> translationsproject.org, which helps both you and us translators in
> handling all the uninteresting tool-bashing itself. Submit an updated
> POT file when strings are frozen, and download all the updated
> translations before releasing.

This has come up before on the mailing list.  We talked about moving
to translationsproject.org but decided against it at that time as
the current pool of translators for Git felt the dictionary involved
was too technical (and too Git specific) for the run-of-the-mill
translators who work through translationsproject.org.  At least some
knowledge of Git is required to get a good translation, and we cannot
except all translators to have that.

So translation work is still here, on this mailing list.

-- 
Shawn.
