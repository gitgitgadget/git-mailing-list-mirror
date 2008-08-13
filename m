From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Local uncommitted changes, not checked in to index with gitk
Date: Wed, 13 Aug 2008 13:36:09 +0200
Message-ID: <vpqljz1cfkm.fsf@bauges.imag.fr>
References: <ace3f33d0808130207w109e834bxa12b3e96ce3ec096@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 13:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTEfG-0007i5-PG
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 13:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbYHMLgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 07:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbYHMLgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 07:36:16 -0400
Received: from imag.imag.fr ([129.88.30.1]:34281 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbYHMLgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 07:36:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7DBa9Yx019477
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Aug 2008 13:36:09 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KTEe9-0007Mt-6Q; Wed, 13 Aug 2008 13:36:09 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KTEe9-0001U6-4A; Wed, 13 Aug 2008 13:36:09 +0200
In-Reply-To: <ace3f33d0808130207w109e834bxa12b3e96ce3ec096@mail.gmail.com> (srinivas naga vutukuri's message of "Wed\, 13 Aug 2008 14\:37\:02 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 13 Aug 2008 13:36:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92210>

"srinivas naga vutukuri" <srinivas.vutukuri@gmail.com> writes:

> just cloning any git repository, next time onwards after pulling
> changes, the gitk is showing
> at the top "Local uncommitted changes, not checked in to index". Why
> it is happening.

What do "git status" and "git diff" say?

-- 
Matthieu
