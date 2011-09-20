From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] t4014: remove Message-Id/timestamp before comparing patches
Date: Tue, 20 Sep 2011 10:43:41 +0200
Message-ID: <201109201043.41267.trast@student.ethz.ch>
References: <6b2cb6ebec907342a02d56a36ddc58715efabc00.1316414731.git.trast@student.ethz.ch> <20110919191545.GD26115@sigill.intra.peff.net> <7vr53c9tlt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Pang Yan Han <pangyanhan@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 10:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5vvg-0007Wb-Qk
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 10:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab1ITIno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 04:43:44 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:42060 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681Ab1ITInn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 04:43:43 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 20 Sep
 2011 10:43:28 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 20 Sep
 2011 10:43:41 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7vr53c9tlt.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181744>

Junio C Hamano wrote:
> Thanks, your fix makes a lot more sense.

Agreed.  Thanks!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
