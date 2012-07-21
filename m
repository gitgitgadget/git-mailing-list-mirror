From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 1/7] i18n: New keywords for xgettext extraction from sh
Date: Sat, 21 Jul 2012 18:20:25 +0200
Message-ID: <500AD6C9.7030802@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com> <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 18:20:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SscQ1-0006Ch-7F
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 18:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab2GUQUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 12:20:32 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50245 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab2GUQUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 12:20:31 -0400
Received: by bkwj10 with SMTP id j10so4169923bkw.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=SYktE6DptHy/UGafc8YAqFhErhESeTCK7tDq4rwwMGw=;
        b=KrE/0xKvVFc8F6OlTWenjkAan7rG3a02gwsgv+FRae0mZC8JQsKqLqa07wcJSVIjxp
         vQaB+rvOQ4ivLbuetG+I8zdkSM+t38B4sHDvr8SQksrMI4bJyTkQe138PxVC/QY2aUQf
         AG8KggqCJego7YmODStP3kdU4oHv1W5o0RCfxOVFUKdQuzmBY/GeDP9SyGcNbghZzdYh
         u4G3EE2ANQcZKxKdUbjr6TBrP8FFzQn1df3A8H7FEFkTy9YgCYhIZzsYN0SVidmNxTFu
         rumWKxDc1T8aGZHmnXcqxnUbHdIS4nEc4Lkm8Rmb1o1sNsoXEzTV+kUHBw2rusKzazen
         C+uA==
Received: by 10.205.33.136 with SMTP id so8mr4800778bkb.1.1342887630304;
        Sat, 21 Jul 2012 09:20:30 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id 25sm4251509bkx.9.2012.07.21.09.20.28
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 09:20:29 -0700 (PDT)
In-Reply-To: <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201823>

On 07/21/2012 05:50 PM, Jiang Xin wrote:
> Since we have additional shell wrappers (gettextln and eval_gettextln)
> for gettext, we need to take into account these wrapers
>
s/wrapers/wrappers/

Regards,
  Stefano
