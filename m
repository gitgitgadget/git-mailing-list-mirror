From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] vim syntax: highlight the diff in commit message template
Date: Wed, 24 Sep 2008 19:01:54 +0200
Message-ID: <20080924170154.GA6816@neumann>
References: <1222269726-15632-1-git-send-email-szeder@ira.uka.de>
	<20080924155745.GA3908@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:04:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXmh-0000LC-14
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341AbYIXRDA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 13:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbYIXRDA
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:03:00 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:59855 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYIXRC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:02:59 -0400
Received: from [127.0.1.1] (p5B13362F.dip0.t-ipconnect.de [91.19.54.47])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1KiXkQ1u4y-0005Zx; Wed, 24 Sep 2008 19:01:55 +0200
Content-Disposition: inline
In-Reply-To: <20080924155745.GA3908@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+EXp5EryV1tFaup21ZugH2RUuwUQU2ba7wTGF
 YGMbxawS8/6Jqa2nmvj8V7uqqPV4kLUN74tOdfg62w3/gKXkJ1
 JXT/3XPLHri/lV6DTSLrg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96664>

Hi,

On Wed, Sep 24, 2008 at 11:57:45AM -0400, Jeff King wrote:
> Is there any objection to simply removing it (and probably replacing =
it
> with a note to go look at the official highlighting file)?
I'm for it, because I didn't know that there is an official git syntax
highlight file out there.  Indeed, I haven't even know that vim 7.2 is
out.

Thanks,
G=E1bor
