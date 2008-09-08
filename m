From: Christoph Hellwig <hch@lst.de>
Subject: Re: git apply vs. renamed files index mismatch (was: Re: [PATCH 1/4] POWERPC: Rename dma_64.c to dma.c)
Date: Mon, 8 Sep 2008 23:58:33 +0200
Message-ID: <20080908215833.GC1175@lst.de>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com> <1220900995-11928-2-git-send-email-becky.bruce@freescale.com> <48C57A92.6060608@freescale.com> <20080908212717.GA21338@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>, git@vger.kernel.org,
	linuxppc-dev@ozlabs.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcom6-00052s-HW
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbYIHV6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 17:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbYIHV6w
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:58:52 -0400
Received: from verein.lst.de ([213.95.11.210]:54987 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbYIHV6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 17:58:51 -0400
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m88LwYIF001567
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Sep 2008 23:58:34 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m88LwXlR001564;
	Mon, 8 Sep 2008 23:58:33 +0200
Content-Disposition: inline
In-Reply-To: <20080908212717.GA21338@oksana.dev.rtsoft.ru>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.001 () BAYES_44
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95309>

On Tue, Sep 09, 2008 at 01:27:17AM +0400, Anton Vorontsov wrote:
> I always thought that posting "-M" patches to the public lists is
> discouraged since it is quite difficult to apply them via patch(1).
> Also think of non-git users...

Yes, it's a horrible idea.
