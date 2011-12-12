From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] Makefile: Windows lacks /dev/tty
Date: Mon, 12 Dec 2011 22:52:11 +0100
Message-ID: <4EE6778B.4000803@kdbg.org>
References: <20111210103943.GA16478@sigill.intra.peff.net> <20111210104130.GI16648@sigill.intra.peff.net> <4EE66DAB.5070407@kdbg.org> <20111212211801.GA9754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaDnF-0005IJ-R0
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab1LLVwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:52:13 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:59653 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751549Ab1LLVwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:52:13 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CFB45A7EB7;
	Mon, 12 Dec 2011 22:52:35 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 364EF19F5F7;
	Mon, 12 Dec 2011 22:52:11 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20111212211801.GA9754@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186958>

Am 12.12.2011 22:18, schrieb Jeff King:
> The most recent version of the prompt series has platforms opting into
> the replacement with HAVE_DEV_TTY.

I see. Obviously, I've tested an earlier iteration. This patch can be
dropped then.

-- Hannes
