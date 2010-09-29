From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [GITK PATCH] gitk: add menuitem for file checkout from selected or parent commit
Date: Wed, 29 Sep 2010 17:27:44 +0200
Message-ID: <201009291727.45467.barra_cuda@katamail.com>
References: <20100928200344.GA12843@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 17:32:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ye5-0005uq-0j
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 17:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab0I2PcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 11:32:18 -0400
Received: from smtp226-pc.aruba.it ([62.149.157.226]:52296 "HELO
	smtp1-pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753639Ab0I2PcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 11:32:16 -0400
Received: (qmail 23738 invoked by uid 89); 29 Sep 2010 15:32:10 -0000
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on smtp1-pc.ad.aruba.it
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=6.5 tests=BAYES_50,FREEMAIL_FROM
	autolearn=no version=3.3.1
Received: from unknown (HELO darkstar.localnet) (barra?cuda@katamail.com@78.134.70.234)
  by smtp1-pc.ad.aruba.it with SMTP; 29 Sep 2010 15:32:09 -0000
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc5-debug-2mike; KDE/4.5.1; i686; ; )
In-Reply-To: <20100928200344.GA12843@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157579>

On Tuesday 28 September 2010, Heiko Voigt wrote:
>  po/de.po |    6 ++++++
>  po/es.po |    6 ++++++
>  po/fr.po |    6 ++++++
>  po/hu.po |    6 ++++++
>  po/it.po |    6 ++++++
>  po/ja.po |    6 ++++++
>  po/ru.po |    6 ++++++
>  po/sv.po |    6 ++++++

You shouldn't change anything under po/ (unless you want to actually translate
something, of course): translators will do it for you. There would be less
of a chance of a conflicting merge.
