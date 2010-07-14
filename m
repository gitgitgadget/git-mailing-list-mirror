From: Daniel Shahaf <d.s@daniel.shahaf.name>
Subject: Re: [PATCH 1/9] Add LICENSE
Date: Wed, 14 Jul 2010 07:47:12 +0300
Message-ID: <20100714044712.GB3081@daniel3.local>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com> <1279064176-6645-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 06:47:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYtss-0008EB-Up
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 06:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab0GNErp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 00:47:45 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36657 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751437Ab0GNEro (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 00:47:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 06CBE16EA4D;
	Wed, 14 Jul 2010 00:47:44 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 14 Jul 2010 00:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=smtpout; bh=+QH9FDv9usu6nwgeJOywFYGIHO4=; b=eOGSfCWESdC93yh3jWITEbwWtCbnTrqwEzzI2JIQtSzuTWKeWnmZPn8yD2hLxjCBOH9vif/vGmDF5z88kF2Ks3huSvvy1HvDDOeV9ZEQSz5Oc+R+fjOCbq9EIeiRQMh3GUyOrNFLpevJU28gCgPsaS8/Z9ZjWKPxjsLRRBNmBFI=
X-Sasl-enc: O7BuPdyvza60kAuC2LjYSzbiYBY/x1xaWvcDy+qp2kLH8H4uYqghJFWmr8shbA 1279082863
Received: from daniel3.local (bzq-79-182-17-192.red.bezeqint.net [79.182.17.192])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2343620288;
	Wed, 14 Jul 2010 00:47:40 -0400 (EDT)
Mail-Followup-To: Daniel Shahaf <d.s@daniel.shahaf.name>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, Will Palmer <wpalmer@gmail.com>,
	Greg Stein <gstein@gmail.com>
Content-Disposition: inline
In-Reply-To: <1279064176-6645-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150963>

[ are all of these CCs really necessary?  that's another thing I almost never
see over at dev@svn ]

Ramkumar Ramachandra wrote on Wed, Jul 14, 2010 at 01:36:08 +0200:
> License the project under a two-clause BSD-style license. A dual
> license will be required later when attempting to merge into
> Subversion.
> 

If it ends in svn trunk as subversion/svnrdump/ (and not as a tools/ utility),
it's going to have to be licensed under the Apache License v2.

Daniel
(AFAIK)

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  LICENSE |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
>  create mode 100644 LICENSE
> 
> diff --git a/LICENSE b/LICENSE
> new file mode 100644
> index 0000000..4367b7c
> --- /dev/null
> +++ b/LICENSE
> @@ -0,0 +1,26 @@
> +Copyright (C) 2010 Ramkumar Ramachandra
> +All rights reserved.
> +
> +Redistribution and use in source and binary forms, with or without
> +modification, are permitted provided that the following conditions
> +are met:
> +1. Redistributions of source code must retain the above copyright
> +   notice(s), this list of conditions and the following disclaimer
> +   unmodified other than the allowable addition of one or more
> +   copyright notices.
> +2. Redistributions in binary form must reproduce the above copyright
> +   notice(s), this list of conditions and the following disclaimer in
> +   the documentation and/or other materials provided with the
> +   distribution.
> +
> +THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER(S) ``AS IS'' AND ANY
> +EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> +IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
> +PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) BE
> +LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> +CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> +SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> +BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
> +WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
> +OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
> +EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> -- 
> 1.7.1
> 
