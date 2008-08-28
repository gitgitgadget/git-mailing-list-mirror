From: Al Viro <viro@hera.kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 11:54:08 +0000
Message-ID: <20080828115408.GA30834@hera.kernel.org>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org> <20080827001705.GG23698@parisc-linux.org> <7v63pmkozh.fsf@gitster.siamese.dyndns.org> <1219907659.7107.230.camel@pmac.infradead.org> <7vtzd5fta0.fsf@gitster.siamese.dyndns.org> <1219912327.7107.245.camel@pmac.infradead.org> <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 13:57:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYg7X-0005Oo-Mz
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 13:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbYH1Lzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 07:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYH1Lzz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 07:55:55 -0400
Received: from hera.kernel.org ([140.211.167.34]:34663 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997AbYH1Lzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 07:55:54 -0400
Received: from hera.kernel.org (IDENT:U2FsdGVkX1/hmRO2OvXu9N+0kxEfH+qEBNcx9GFACOA@localhost [127.0.0.1])
	by hera.kernel.org (8.14.2/8.14.2) with ESMTP id m7SBsTV8026342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 11:54:29 GMT
Received: (from viro@localhost)
	by hera.kernel.org (8.14.2/8.13.1/Submit) id m7SBs8GN026297;
	Thu, 28 Aug 2008 11:54:08 GMT
Content-Disposition: inline
In-Reply-To: <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.3/8104/Thu Aug 28 02:11:35 2008 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (hera.kernel.org [127.0.0.1]); Thu, 28 Aug 2008 11:54:50 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94040>

On Thu, Aug 28, 2008 at 11:57:56AM +0300, Felipe Contreras wrote:

> The masses should forget about the git-foo form. If you push people
> into using git-foo then you are not following git guidelines; you
> would be pushing your own agenda.

Egads...  For sarcasm it's far too heavy-handed and if that's for real...
What's next, verbal diarrhea about Diluting the Message(tm)?
