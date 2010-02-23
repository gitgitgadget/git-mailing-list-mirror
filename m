From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] BROKEN -- format-patch: learn to fill comment section of email from notes
Date: Tue, 23 Feb 2010 18:37:10 +0100
Message-ID: <201002231837.11245.trast@student.ethz.ch>
References: <6cf9010742df96e0c68ef8adc1ab392c08525bc2.1266946262.git.trast@student.ethz.ch> <fe0d69eba1b0265c0ca913831ba26e643062f8eb.1266946248.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 18:37:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njyhk-0006vX-7Q
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 18:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353Ab0BWRhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 12:37:47 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:15169 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660Ab0BWRhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 12:37:46 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 18:37:44 +0100
Received: from thomas.localnet (129.132.210.179) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Tue, 23 Feb
 2010 18:37:45 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <fe0d69eba1b0265c0ca913831ba26e643062f8eb.1266946248.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140820>

On Tuesday 23 February 2010 18:34:56 Thomas Rast wrote:
> [PATCH] BROKEN -- format-patch: learn to fill comment section of email from notes

BTW, I forgot to say: the breakage is visible in either t4013 or
t4014, depending which way you tweak the newlines.

IIRC there's also a problem with this patch and Signed-off-by
handling, which I didn't bother fixing because I couldn't get the
newlines right.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
