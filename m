From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: small misspellings fixes
Date: Wed, 19 Jun 2013 07:51:12 +0200
Message-ID: <vpq7ghqmywf.fsf@anie.imag.fr>
References: <alpine.DEB.2.00.1306190733440.8850@citymarket.hu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Veres Lajos <vlajos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 07:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpBIr-0002ic-A9
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 07:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355Ab3FSFvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 01:51:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60856 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739Ab3FSFvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 01:51:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5J5pCPi012236
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 19 Jun 2013 07:51:12 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UpBIW-0001Vp-Vt; Wed, 19 Jun 2013 07:51:13 +0200
In-Reply-To: <alpine.DEB.2.00.1306190733440.8850@citymarket.hu> (Veres Lajos's
	message of "Wed, 19 Jun 2013 07:37:24 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Jun 2013 07:51:13 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228344>

Veres Lajos <vlajos@gmail.com> writes:

> I am trying to convert this pull request:
> https://github.com/git/git/pull/42
> to a proper patch email

Use "git format-patch" and/or "git send-email" to get the proper
formatting.

> (Sorry If I miss something about the process.)

Yes, your patch doesn't have exactly the right format, and you should
have Cc-ed Junio (see Documentation/SubmittingPatches in Git's source
tree).

Other than that, the content of the patch looks good (and actually, at
least one of the typos is mine :-( ). Can you resend?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
