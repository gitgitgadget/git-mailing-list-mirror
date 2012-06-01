From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Getting the commit that corresponds to a specific annotated tag
Date: Fri, 1 Jun 2012 17:27:35 -0500
Message-ID: <CA+mfgz1DOzB6=m3uLBtAULRZd7TR90M9mDDFFK2dxB+RpWC9kw@mail.gmail.com>
References: <CA+mfgz2=ZFBetSGv1Bkq6orBbpVTS1k0gLVm0nGoR1sUDkDwqQ@mail.gmail.com>
 <7vd35i1ymz.fsf@alter.siamese.dyndns.org> <CA+mfgz0GqTKwOg6b=6rPUUnS6kwXZfCCYE7SOVHFcqrjRpOiTw@mail.gmail.com>
 <7v8vg61xn5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:28:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaaKv-0000lN-Ql
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 00:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759498Ab2FAW2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 18:28:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55892 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab2FAW2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 18:28:16 -0400
Received: by yenm10 with SMTP id m10so2196604yen.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bmny/4I3VTxDTKkflcPKHeS/LD0hwLQPaFNXAlCOkUc=;
        b=vTIbLMnidOiRhkcTFVqdREUK2V43BV2MfmTpqNo8pYI9T82VEmxf+IV8wDpRjBHkXD
         gGf97llTjKWLpbQml5ReoxB6UvTURMDI8Yw2NXcfOPQ3TOndgsSDMwrGin2FLw8+iN4v
         KHcn1kluDq2ndDJjUQJHUExayctouBotltj5AS8Mr0EAk+4vWuue3WD+TO7Z3AO/igIX
         NDuYjEIJfnvm0mo6ir/opjlgAZr+KKtHDNx5oFsob4r1NNkiUDnyK7kr8sLP6fdBrDmV
         MKi58L/z4YojpNddueNf47nN6anxOUGUNcdVyEnuoardN/XsXu6ZIuTdFMAeJWyMw2dA
         XVqQ==
Received: by 10.236.126.15 with SMTP id a15mr380489yhi.14.1338589695889; Fri,
 01 Jun 2012 15:28:15 -0700 (PDT)
Received: by 10.147.97.23 with HTTP; Fri, 1 Jun 2012 15:27:35 -0700 (PDT)
In-Reply-To: <7v8vg61xn5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199030>

On Fri, Jun 1, 2012 at 5:21 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Didn't you say you were writing a Porcelain?

Ahh, I get you. Porcelain was probably the wrong word...

Cheers

Adam
