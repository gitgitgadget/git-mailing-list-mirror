From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: fatal: git grep: cannot generate relative filenames containing
	'..'
Date: Fri, 16 Jan 2009 12:41:44 +0100
Message-ID: <20090116114144.GA29537@neumann>
References: <20090115222905.8157.qmail@science.horizon.com>
	<alpine.DEB.1.00.0901160307290.3586@pacific.mpi-cbg.de>
	<7vhc40ov78.fsf@gitster.siamese.dyndns.org>
	<20090116032708.21156.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com, git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 12:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNn6b-0002Yh-FT
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 12:43:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458AbZAPLly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 06:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757350AbZAPLlx
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 06:41:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:49731 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328AbZAPLlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 06:41:52 -0500
Received: from [127.0.1.1] (p5B1338C1.dip0.t-ipconnect.de [91.19.56.193])
	by mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis)
	id 0MKwtQ-1LNn570mTU-0004rG; Fri, 16 Jan 2009 12:41:47 +0100
Content-Disposition: inline
In-Reply-To: <20090116032708.21156.qmail@science.horizon.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX1+CCOlZoC1vit00H4ilVgeFIA/PcPfzWw2Ru9x
 YpN6Bd7kyVoE9fsxe7jsKBsc2+PJwqs4+ma54bsVdzbVrp7Vr1
 BiAuXmNUGfM6KIvf+mKEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105941>

On Thu, Jan 15, 2009 at 10:27:08PM -0500, George Spelvin wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Or perhaps someone did more than two years ago with --full-name?
>=20
> Thank you for pointing that out!  It's a bit of a handful to type,

Well, if you happen to use bash, you will find our excellent ;) bash
completion script under contrib/completion.

hth,
G=E1bor
