From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] cache-tree: update API to take abitrary flags
Date: Thu, 12 Jan 2012 08:20:29 +0700
Message-ID: <CACsJy8CqkCjTeUAyx7h0+PWXCPhRxDG1D5UX886dv=w-M=RHFQ@mail.gmail.com>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
 <1326275982-29866-2-git-send-email-pclouds@gmail.com> <7vmx9t6bs5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 02:21:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl9Lo-0007Dy-DR
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 02:21:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab2ALBVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 20:21:04 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46149 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab2ALBVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 20:21:01 -0500
Received: by bkvi17 with SMTP id i17so884460bkv.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 17:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3HU6ARO2ztCB9JUmfg2hSgWLfyJfmVFlHmf6Jk9aohU=;
        b=MKgMk5Qef3TgZqhPXH31oGBvoHTmo5IFe3LXXoOa/LV6YuofThF9j9aT2ilju0zsWY
         SSCEQh0q7LPq+VJJhtPh03W2gV/UJDVJyIpOTfUFTGUZVv0EVN3zj18NO4g5joUVOeOA
         +2+ZKQJiMTBtl5Cge41l3dVEoUGJPxdLQSpjY=
Received: by 10.205.122.138 with SMTP id gg10mr418134bkc.94.1326331260264;
 Wed, 11 Jan 2012 17:21:00 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Wed, 11 Jan 2012 17:20:29 -0800 (PST)
In-Reply-To: <7vmx9t6bs5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188410>

2012/1/12 Junio C Hamano <gitster@pobox.com>:
> Thanks; this one looks very sensible regardless of what follows (or d=
oes
> not follow). =C2=A0Forgot to sign-off?

Deliberately to stop you from using it because I did not test it
carefully. It was created as material for the discussion only. Will
resubmit later.
--=20
Duy
