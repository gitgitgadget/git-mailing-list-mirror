From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: git-gui translators - please update translations if necessary
Date: Mon, 4 Aug 2008 12:17:37 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0808041215140.4744@ds9.cixit.se>
References: <20080802211714.GG24723@spearce.org> <7vod4bccx8.fsf@gitster.siamese.dyndns.org>
 <20080802214930.GA25311@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 13:19:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPy5d-0003Be-Br
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 13:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbYHDLRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 07:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753096AbYHDLRw
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 07:17:52 -0400
Received: from ds9.cixit.se ([193.15.169.228]:51645 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbYHDLRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 07:17:52 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m74BHc5e017951
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 4 Aug 2008 13:17:38 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m74BHbxc017946;
	Mon, 4 Aug 2008 13:17:37 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080802214930.GA25311@spearce.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 04 Aug 2008 13:17:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91341>

Shawn O. Pearce:

> > Perhaps you wanted to update git-gui.pot first before sending this request
> > out?

> Oh.  Its updated now, but msgmerge on my system is busted and won't
> update the po files themselves.  *sigh*

In that case I would recommend submitting the translation to
translationsproject.org, which helps both you and us translators in
handling all the uninteresting tool-bashing itself. Submit an updated
POT file when strings are frozen, and download all the updated
translations before releasing.

-- 
\\// Peter - http://www.softwolves.pp.se/
