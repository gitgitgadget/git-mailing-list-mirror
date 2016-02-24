From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 0/5] Make README more pleasant to read
Date: Wed, 24 Feb 2016 14:37:05 +0100
Message-ID: <vpqziuq6xha.fsf@anie.imag.fr>
References: <1456249229-30454-1-git-send-email-Matthieu.Moy@imag.fr>
	<20160224102247.GA21152@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, emma.westby@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 14:38:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYZdi-0004Fk-7v
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 14:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbcBXNhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 08:37:22 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59639 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608AbcBXNhU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 08:37:20 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1ODb4Lc001436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 24 Feb 2016 14:37:04 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1ODb53i028388;
	Wed, 24 Feb 2016 14:37:05 +0100
In-Reply-To: <20160224102247.GA21152@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 24 Feb 2016 05:22:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Feb 2016 14:37:04 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1ODb4Lc001436
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456925825.02653@T6qEZHcQ6C81MGsphdxEVg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287209>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 23, 2016 at 06:40:24PM +0100, Matthieu Moy wrote:
>
>>  README => README.md | 54 ++++++++++++++++++++++++++++-------------------------
>>  t/t7001-mv.sh       |  2 +-
>
> I do not overly care, but I wonder if it would be nice to keep README as
> a symlink.

I can add it if people want to see it, but we already have so many files
at the root, I'd rather avoid adding duplicates through symlinks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
