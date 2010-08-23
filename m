From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/3] git-bundle.txt: Cleanup
Date: Mon, 23 Aug 2010 13:59:00 +0200
Message-ID: <201008231359.00417.trast@student.ethz.ch>
References: <cover.1282553585.git.git@drmicha.warpmail.net> <4cc5ea19fda713050f3f247d32df44fcfcea3296.1282553586.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 23 13:59:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnVgW-0004RE-NX
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 13:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab0HWL7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 07:59:24 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:51490 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab0HWL7X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 07:59:23 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 23 Aug
 2010 13:59:23 +0200
Received: from thomas.site (129.132.246.171) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 23 Aug
 2010 13:59:01 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <4cc5ea19fda713050f3f247d32df44fcfcea3296.1282553586.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154219>

Michael J Gruber wrote:
> Cleanup various spellings of the same argument
[...]
> -       'git rev-list' arguments to define the bundle contents.
> +       'git-rev-list-args' arguments to define the bundle contents.

As indicated by the Cc but not the text, this was fallout from my
automated replacements in 0b444cd (Documentation: spell 'git cmd'
without dash throughout, 2010-01-10).

An analogous change to one of your {tilde} replacements is already in
Jonathan's series.  The rest probably don't hurt, if only to drive
people towards a more consistent {tilde} spelling in the future.

So, Ack.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
