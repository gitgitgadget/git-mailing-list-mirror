From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/4] Documentation style fixes
Date: Sun, 10 Jan 2010 01:07:27 +0100
Message-ID: <201001100107.29920.trast@student.ethz.ch>
References: <7vaawp4wvz.fsf@alter.siamese.dyndns.org> <cover.1263081032.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 01:07:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTlLE-0005po-5n
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 01:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab0AJAHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 19:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927Ab0AJAHc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 19:07:32 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:57594 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664Ab0AJAHc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 19:07:32 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:07:30 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:07:30 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <cover.1263081032.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136545>

Thomas Rast wrote:
>   Documentation: spell 'git cmd' without dash throughout
[...]
>  115 files changed, 634 insertions(+), 626 deletions(-)

Turns out the fourth patch is over 200kB and can't be sent over the
list.  I pushed the whole series to

  git://repo.or.cz/git/sbeyer.git t/doc-merge-revamp

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
