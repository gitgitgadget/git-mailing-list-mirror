From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] builtin-apply.c: Skip filenames without enough components
Date: Mon, 18 Jan 2010 20:57:40 +0100
Organization: SUSE Labs
Message-ID: <201001182057.41032.agruen@suse.de>
References: <201001170305.10793.agruen@suse.de> <201001170344.34525.agruen@suse.de> <20100118192235.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 20:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWxjX-0002UG-CQ
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 20:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab0ART5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 14:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994Ab0ART5t
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 14:57:49 -0500
Received: from cantor.suse.de ([195.135.220.2]:44892 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab0ART5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 14:57:49 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 467E49428F;
	Mon, 18 Jan 2010 20:57:48 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20100118192235.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137398>

On Monday 18 January 2010 11:22:35 am Nanako Shiraishi wrote:
> Junio, in case you don't want to wait for Andreas, you can squash this test
>  in.

Thanks, looks good!

Andreas
