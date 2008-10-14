From: Folkert van Heusden <folkert@vanheusden.com>
Subject: Re: retrieving a diff from git
Date: Tue, 14 Oct 2008 19:20:49 +0200
Organization: www.unixexpert.nl
Message-ID: <20081014172048.GW22427@vanheusden.com>
References: <20081014145112.GR22427@vanheusden.com> <81b0412b0810141001w46227afam70123237025a2d4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 19:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpnb9-0004wg-7F
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 19:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbYJNRUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 13:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbYJNRUx
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 13:20:53 -0400
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:3250 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYJNRUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 13:20:52 -0400
Received: from keetweej.vanheusden.com (keetweej.vanheusden.com [80.126.110.251])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id m9EHKnJX025761;
	Tue, 14 Oct 2008 19:20:49 +0200 (CEST)
	(envelope-from folkert@vanheusden.com)
Received: from belle.intranet.vanheusden.com (belle.intranet.vanheusden.com [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id 4396E82CD;
	Tue, 14 Oct 2008 19:20:49 +0200 (CEST)
Received: by belle.intranet.vanheusden.com (Postfix, from userid 1000)
	id 3C13E40226; Tue, 14 Oct 2008 19:20:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0810141001w46227afam70123237025a2d4d@mail.gmail.com>
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Oct 11 11:14:03 CEST 2008
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98202>

> > How would I retrieve the 'kmemcheck' patches from git for the 2.6.27
> > kernel? I browsed to the url
> > http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Fx86%2Flinux-2.6-tip.git...
> > but could not find how to retrieve that diff.
> Well, you can of course just click on "commitdiff" (and "raw" afterwords)
> for every commit,

Hmmm the outcome does not apply cleanly to 2.6.27.

> but ... Have you considered using Git for that?

and check out the whole tree using Git? I did consider but then I would
not have all bells and whistles to generate a Debian kernel package.


Folkert van Heusden

-- 
MultiTail is a versatile tool for watching logfiles and output of
commands. Filtering, coloring, merging, diff-view, etc.
http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
