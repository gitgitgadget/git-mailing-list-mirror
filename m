From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/7] Change to call the new emit_line.
Date: Mon, 17 May 2010 08:45:58 +0200
Message-ID: <201005170845.59018.trast@student.ethz.ch>
References: <1273921331-32702-1-git-send-email-struggleyb.nku@gmail.com> <1273921331-32702-2-git-send-email-struggleyb.nku@gmail.com> <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 08:46:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODu5u-0002vI-6T
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 08:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab0EQGqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 02:46:24 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:35789 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab0EQGqX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 02:46:23 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 08:46:22 +0200
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 17 May
 2010 08:46:00 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <1273921331-32702-3-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147209>

Bo Yang wrote:
> Call the new emit_line function.

This should be squashed into the last patch so as to keep the
resulting code working.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
