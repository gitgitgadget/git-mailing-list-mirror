From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] checkout without arguments does not make sense
Date: Mon, 21 Jul 2008 23:11:17 +0200
Message-ID: <200807212311.17612.johannes.sixt@telecom.at>
References: <200807212206.32818.johannes.sixt@telecom.at> <20080721204955.GI32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 23:12:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL2g7-0007w2-Ro
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 23:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbYGUVLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 17:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbYGUVLU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 17:11:20 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:36524 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYGUVLU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 17:11:20 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 56689BF0DC;
	Mon, 21 Jul 2008 23:11:18 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B27FA19E98;
	Mon, 21 Jul 2008 23:11:17 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080721204955.GI32057@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89405>

On Montag, 21. Juli 2008, Miklos Vajna wrote:
> Actually I think it _is_ useful, like this:
>
> $ git checkout
> Your branch is ahead of the tracked remote branch 'junio/next' by 1 commit.

Ah, yes, indeed; that makes sense. Scrap the patch.

-- Hannes
