From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git push --track
Date: Wed, 13 Jan 2010 17:37:21 +0100
Message-ID: <vpqr5puarlq.fsf@bauges.imag.fr>
References: <op.u6g8jnixg402ra@nb-04> <20100113154310.GA7348@Knoppix>
	<op.u6haiiiog402ra@nb-04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rudolf Polzer" <divVerent@alientrap.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 17:37:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV6Dx-0005Iv-LS
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 17:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009Ab0AMQhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 11:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755984Ab0AMQhd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 11:37:33 -0500
Received: from mx2.imag.fr ([129.88.30.17]:34166 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab0AMQhd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 11:37:33 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o0DGb13X008916
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Jan 2010 17:37:01 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NV6Dh-0006rd-Qj; Wed, 13 Jan 2010 17:37:21 +0100
In-Reply-To: <op.u6haiiiog402ra@nb-04> (Rudolf Polzer's message of "Wed\, 13 Jan 2010 16\:55\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 Jan 2010 17:37:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0DGb13X008916
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264005421.46359@ZjlUcMDAx/WlPWVPLBtvaQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136839>

"Rudolf Polzer" <divVerent@alientrap.org> writes:

> Of course, but I assume the sign-off would not be by me, but by some
> of  the git developers, and would depend on whether they actually want
> this  feature.

Read Documentation/SubmittingPatches in Git's source to make sure you
understand what Signed-off-by: means for the Git project.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
