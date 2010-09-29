From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Rebase with tags
Date: Wed, 29 Sep 2010 14:20:29 +0200
Message-ID: <201009291420.29871.trast@student.ethz.ch>
References: <AANLkTinQm8kVA_rCgX_SN=fX_2a0UU78aiOHr-YtO6zK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Leonid Podolny <leonidp.lists@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 14:21:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0veg-0007ak-Oj
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 14:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0I2MUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 08:20:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:21033 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296Ab0I2MUd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 08:20:33 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 29 Sep
 2010 14:20:30 +0200
Received: from thomas.site (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 29 Sep
 2010 14:20:30 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34.7-0.3-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <AANLkTinQm8kVA_rCgX_SN=fX_2a0UU78aiOHr-YtO6zK@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157560>

Leonid Podolny wrote:
> Is it possible, at least, to receive a set of (old commit, new commit)
> pairs, so that I will write a little script that will do that for me?

The post-rewrite hook gets this list, so you can use that if you want
to.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
