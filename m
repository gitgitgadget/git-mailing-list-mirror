From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Correct help blurb in checkout -p and friends
Date: Thu, 28 Oct 2010 02:53:18 +0200
Message-ID: <201010280253.18833.trast@student.ethz.ch>
References: <1288226960-31584-1-git-send-email-jonathan@leto.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Jonathan \"Duke\" Leto" <jonathan@leto.net>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 02:53:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBGkE-0000VF-Ks
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 02:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924Ab0J1Ax0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 20:53:26 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:59374 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757889Ab0J1AxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 20:53:25 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 28 Oct
 2010 02:53:24 +0200
Received: from pctrast.inf.ethz.ch (129.132.209.98) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 28 Oct
 2010 02:53:23 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc8-32-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <1288226960-31584-1-git-send-email-jonathan@leto.net>
X-Originating-IP: [129.132.209.98]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160144>

Jonathan "Duke" Leto wrote:
> When git checkout -p from the index or HEAD is run in edit mode, the
> help message about removing '-' and '+' lines was backwards. Because it
> is reverse applying the patch, the meanings of '-' and '+' are reversed.
> 
> Signed-off-by: Jonathan "Duke" Leto <jonathan@leto.net>

Acked-by: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
