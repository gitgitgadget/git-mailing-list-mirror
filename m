From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/3] gettext: minor fixes
Date: Mon, 30 Aug 2010 14:35:26 +0000
Message-ID: <AANLkTikdw_azkLvFuGECx+twEcijyhyLVUoYG389xUxx@mail.gmail.com>
References: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 16:35:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5SW-00064s-8r
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738Ab0H3Of2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 10:35:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43725 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab0H3Of1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 10:35:27 -0400
Received: by fxm13 with SMTP id 13so3251524fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aPBjFlC9jkw1e3CKdPS5DdxbWamnqULk9u/U0P6qiw4=;
        b=ITsy8YERUFTxV2eirw+UhT+6ObSQaa3w73RVuWIl/2ViS4PmXSnj668KzpsnQABeGB
         kXA6wWvc+WzEP2tlDkw6jUgGF9jz3A+XiGapn74A+sO17s9zGSlPKHF2GPbmk21dpftJ
         p+cmq1riLD+fXMljzTkYgbbG7+RpsIeBjW/TY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YlKKUH4pPk6l2f7nPDF4e4k6b0Wq8xvEVMJAkCXzOnT4qTeYBjevwmpYIVE82CSdir
         5mihAL8FpN3D0RECxQA7ErifokIfi1BtzJrd1J3hQSyPAfty1w5AqVbBG/AFiXU4IVC9
         EG5mlFr4lhTH7DiT3dUrYicrdAUI1SckqKtog=
Received: by 10.223.111.78 with SMTP id r14mr3940932fap.29.1283178926641; Mon,
 30 Aug 2010 07:35:26 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 30 Aug 2010 07:35:26 -0700 (PDT)
In-Reply-To: <1283018063-4256-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154815>

On Sat, Aug 28, 2010 at 17:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Here are some trivial fixes to the gettext infrastructure. I
> encountered these while doing more significant work.
>
> It's based on next, and the gettext series I'm about to send soon wil=
l
> be based on this one.

Please disregard this series. It has a bug, and in any case it's
better folded into a future gettext series that I'll submit later.
