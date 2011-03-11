From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Summer of Code project ideas due this Friday
Date: Fri, 11 Mar 2011 14:31:03 +0100
Message-ID: <201103111431.04066.trast@student.ethz.ch>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <201103101815.23477.trast@student.ethz.ch> <20110310184653.GA17832@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 14:31:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py2Qx-0002TX-8O
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 14:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab1CKNbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 08:31:06 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:14081 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012Ab1CKNbF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 08:31:05 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.270.1; Fri, 11 Mar
 2011 14:30:52 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.270.1; Fri, 11 Mar
 2011 14:31:04 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-9-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110310184653.GA17832@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168898>

Jeff King wrote:
> On Thu, Mar 10, 2011 at 06:15:23PM +0100, Thomas Rast wrote:
> 
> > * Clean up add -p
> 
> One more wishlist item for this. I use "add -p" for almost all of my
> adds these days, because I like the final review check. So after a
> conflicted merge, I find myself doing "add -p" to stage my resolution.
> The current behavior is that it shows the --cc diff and exits. It would
> be cool to handle staging the resolution, which would involve converting
> the combined diff into something that can be applied.

Good idea, thanks.

I put this (with your idea) and the word-merge thing on the wiki.
I'll let Jonathan decide what to do about the fast-import stream
filtering.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
