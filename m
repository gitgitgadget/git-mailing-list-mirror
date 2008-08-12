From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git rebase UI
Date: Tue, 12 Aug 2008 11:13:34 +0200
Message-ID: <vpqd4ke4mv5.fsf@bauges.imag.fr>
References: <779511aa-4bf5-4e20-845a-4534a1875324@r15g2000prd.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bain <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 11:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSpzX-00042W-Oq
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 11:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbYHLJPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 05:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYHLJPd
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 05:15:33 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:45747 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbYHLJPc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 05:15:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7C9DZDv019881;
	Tue, 12 Aug 2008 11:13:35 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KSpwc-0005hl-7o; Tue, 12 Aug 2008 11:13:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KSpwc-00061M-5X; Tue, 12 Aug 2008 11:13:34 +0200
In-Reply-To: <779511aa-4bf5-4e20-845a-4534a1875324@r15g2000prd.googlegroups.com> (bain@devslashzero.com's message of "Tue\, 12 Aug 2008 02\:02\:58 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 12 Aug 2008 11:13:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92084>

bain <bain@devslashzero.com> writes:

> I am in middle of designing a UI for interactive git rebase,

Did you look at the Google SoC on "Git sequencer"?

Dunno the details, but AAUI, it's meant to be plumbing to build
better porcelain rebase on top of.

(Yes, I don't answer the question of usability, sorry ;-) ).

-- 
Matthieu
