From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 0/4] Signed push
Date: Sat, 10 Sep 2011 20:05:07 +0000
Message-ID: <robbat2-20110910T193556-827326546Z@orbis-terrarum.net>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
 <7vipp1otyp.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hWVPCEeJKKccp4Wc-j+XMSFXqRf6VYd7ngLER8RhODRQ@mail.gmail.com>
 <7vehzopdga.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	" Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 10 22:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2Tnf-0003pU-TI
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 22:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933849Ab1IJUFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 16:05:10 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:53645 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933495Ab1IJUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 16:05:09 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 9CFB81B402A
	for <git@vger.kernel.org>; Sat, 10 Sep 2011 20:05:08 +0000 (UTC)
Received: (qmail 24752 invoked by uid 10000); 10 Sep 2011 20:05:07 -0000
Content-Disposition: inline
In-Reply-To: <7vehzopdga.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181161>

On Sat, Sep 10, 2011 at 09:30:29AM -0700,  Junio C Hamano wrote:
> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> > I think this is also some further motivation to have a
> 
> Did you miss that I already mentioned that workaround?  It does not _fix_
> the fundamental breakage, which is that you are _forcing_ the sending side
> to keep copies, though.
In the case of a shared Git repo, I'd like to pull copies added by other
developers, so that I can verify the content locally as well. In that
case, I'd need to have copies of the certificates I created as well.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
