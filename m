From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 00/31] Refactor rebase
Date: Tue, 4 Jan 2011 20:57:29 +0100
Message-ID: <201101042057.29809.trast@student.ethz.ch>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:57:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaD0j-0004Tj-Ao
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab1ADT5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:57:32 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:10869 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab1ADT5b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:57:31 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:57:24 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:57:30 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164516>

Martin von Zweigbergk wrote:
> For the past two months, I have been working on refactoring the rebase
> code. See [1] for background information. I have been trying to polish
> the patch set for some time, but now I don't think I will get much
> further without your help.

Thanks a lot for undertaking this effort!  I just finished looking
through the entire series, and it all seems sane to me.  Apart from
j6t's reply I think we're mostly nit-picking or agreeing with you, and
this is the first iteration!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
