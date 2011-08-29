From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that
 start with slashes
Date: Mon, 29 Aug 2011 21:57:59 +0200
Message-ID: <4E5BEF47.5020608@kdbg.org>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu> <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu> <4E58710B.60507@alum.mit.edu> <7vty92adv0.fsf@alter.siamese.dyndns.org> <20110829185011.GC756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 21:58:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy7yC-0008Cj-DZ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 21:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab1H2T6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 15:58:06 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:7346 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754996Ab1H2T6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 15:58:04 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6444410017;
	Mon, 29 Aug 2011 21:57:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2353619F424;
	Mon, 29 Aug 2011 21:57:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <20110829185011.GC756@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180335>

Am 29.08.2011 20:50, schrieb Jeff King:
>      Have you considered publishing the
>      tips of topic branches you apply?

Try 'git remote add github git://github.com/gitster/git' and drop your
jaws on the wealth of branches you get on every 'git fetch github'.

-- Hannes
