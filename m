From: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Subject: Re[2]: [PATCH 3/3] Fixes bug: GIT_PS1_SHOWDIRTYSTATE is no not respect diff.ignoreSubmodules config variable
Date: Mon, 27 Dec 2010 01:42:03 +0300
Message-ID: <255471532.20101227014203@mail.ru>
References: <1293240049-7744-1-git-send-email-zapped@mail.ru> <1293240049-7744-3-git-send-email-zapped@mail.ru> <4D15E48A.9050805@web.de> <7vd3ooz6qd.fsf@alter.siamese.dyndns.org>
Reply-To: =?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 26 23:42:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWzID-0001ei-W2
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 23:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037Ab0LZWmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 17:42:09 -0500
Received: from smtp5.mail.ru ([94.100.176.132]:34974 "EHLO smtp5.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021Ab0LZWmG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 17:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=b6Mu0MAB1TxHtbEoAI/dGkKm9a9dkCkAni+zJ5CmygE=;
	b=uX7ZMBDsg+M3p2QWR5GsGx6JMj9ync1Ne71N647WcHFpdH3mWS/SR7K+QH4d4JVxPViMRs3L26JwpmMvU/7qQ/wGDHmQiwQ6aXlMyiplxu2ppBI6m5MRLQhZ0uBJiiWN;
Received: from [91.76.208.161] (port=5421 helo=ppp91-76-208-161.pppoe.mtu-net.ru)
	by smtp5.mail.ru with asmtp 
	id 1PWzHw-0004gv-00; Mon, 27 Dec 2010 01:42:04 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <7vd3ooz6qd.fsf@alter.siamese.dyndns.org>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164202>

JCH> By the way, could we please have a real sign-off, not with a one with a
JCH> pseudonym, given to the series?
Oh, I`m sorry.
Of course.
Should I resend patches with real sign-off, at least first two ones?
