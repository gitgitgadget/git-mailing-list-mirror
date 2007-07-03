From: Bryan Wu <bryan.wu@analog.com>
Subject: Re: [PATCH] Blackfin arch: include/asm-blackfin/macros.h die die
	die
Date: Tue, 03 Jul 2007 08:39:19 +0800
Organization: Analog Devices, Ltd.
Message-ID: <1183423159.10353.10.camel@roc-laptop>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>
	 <4688EF9B.8020405@garzik.org>
	 <9a8748490707020658t5e6542ag6edb435dbc4499ab@mail.gmail.com>
	 <4689073D.1020802@garzik.org>
	 <81b0412b0707020722q25e8eb41t456e7316fe4a7b40@mail.gmail.com>
	 <20070702142926.GB10400@fiberbit.xs4all.nl>
	 <20070702150915.GC10400@fiberbit.xs4all.nl>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Jeff Garzik <jeff@garzik.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Marco Roeland <marco.roeland@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Jul 03 02:39:29 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5WQS-0003so-Px
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 02:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbXGCAjZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 20:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756811AbXGCAjZ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 20:39:25 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:33696 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405AbXGCAjY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 20:39:24 -0400
Received: from nwd2mhb2.analog.com ([137.71.6.12])
  by nwd2mail10.analog.com with ESMTP; 02 Jul 2007 20:39:23 -0400
X-IronPort-AV: i="4.16,489,1175486400"; 
   d="scan'208"; a="44198314:sNHT25531065"
Received: from nwd2exm4.ad.analog.com (nwd2exm4.ad.analog.com [10.64.53.123])
	by nwd2mhb2.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id UAA19076;
	Mon, 2 Jul 2007 20:39:24 -0400 (EDT)
Received: from chinexm1.ad.analog.com ([10.99.27.42]) by nwd2exm4.ad.analog.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Jul 2007 20:39:22 -0400
Received: from 220.232.73.214 ([220.232.73.214]) by chinexm1.ad.analog.com ([10.99.27.42]) via Exchange Front-End Server owa.analog.com ([10.64.25.43]) with Microsoft Exchange Server HTTP-DAV ;
 Tue,  3 Jul 2007 00:39:20 +0000
Received: from roc-laptop by owa.analog.com; 03 Jul 2007 08:39:19 +0800
In-Reply-To: <20070702150915.GC10400@fiberbit.xs4all.nl>
X-Mailer: Evolution 2.10.1 
X-OriginalArrivalTime: 03 Jul 2007 00:39:22.0586 (UTC) FILETIME=[997E43A0:01C7BD0A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51436>

On Mon, 2007-07-02 at 17:09 +0200, Marco Roeland wrote:
> This file accidentally got truncated instead of deleted in commit df30b11.
> Doing a "make distclean" or "make mrproper" deletes this file because of
> its zero size. Git then sees this as an uncommitted local change.
> 
> Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>
> ---
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 include/asm-blackfin/macros.h
> 
> diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
> deleted file mode 100644
> index e69de29..0000000

Thanks already in blackfin-2.6.git tree for Linus pull
Acked by: Bryan Wu <bryan.wu@analog.com>
