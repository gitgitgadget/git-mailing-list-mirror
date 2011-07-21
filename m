From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Command-line options that lack documentation
Date: Thu, 21 Jul 2011 14:34:29 +0200
Message-ID: <201107211434.29677.trast@student.ethz.ch>
References: <CADdV=MsNyhOg7r9NV67e0V1_7FCvdBu4YA=7gAEjPLagP0r9yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Nikolai Weibull <now@bitwi.se>
X-From: git-owner@vger.kernel.org Thu Jul 21 14:34:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjsSb-0004c4-90
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 14:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab1GUMec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 08:34:32 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:4535 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab1GUMec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 08:34:32 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 21 Jul
 2011 14:34:28 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 21 Jul
 2011 14:34:30 +0200
User-Agent: KMail/1.13.7 (Linux/2.6.39.1-33-desktop; KDE/4.6.4; x86_64; ; )
In-Reply-To: <CADdV=MsNyhOg7r9NV67e0V1_7FCvdBu4YA=7gAEjPLagP0r9yw@mail.gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikolai Weibull wrote:
> 
> The following options lack (full) documentation in the manual pages:
[...]
> git-notes copy:
>   --for-rewrite

Intentional, cf. 6956f85 (notes: implement helpers needed for note
copying during rewrite, 2010-03-12).

> Furthermore, the fact that most commands take -h and --help is
> undocumented, but perhaps not of any real importance.

It's actually in gitcli(7).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
