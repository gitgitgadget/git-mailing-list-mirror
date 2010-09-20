From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: svn2git question: error: unknown switch `t'
Date: Mon, 20 Sep 2010 17:58:16 +0000
Message-ID: <AANLkTik_ouA-AD+tmGEvvcJeZqVj4Rge=hcoJ5Bqgt-R@mail.gmail.com>
References: <4E10ACF241081344B9702AA8C6440440C5B14FB331@MX01A.corp.emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: nolan.ring@emc.com
X-From: git-owner@vger.kernel.org Mon Sep 20 19:58:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxkdE-0005zm-OB
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 19:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab0ITR6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 13:58:18 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64153 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab0ITR6R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 13:58:17 -0400
Received: by pxi10 with SMTP id 10so1227312pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5O5MhD6u1A5yMvUeonRSF8rEBV+Yq0UGF3uvR1IJtWo=;
        b=JUlo6EqsxzeTXGPH2lewXk0X2Ll3C1X2upvcValDVu8rFS4pQNRQVNG/BUY3v1lSrz
         8mQoBjgSDLY0SPngveXc8mEc8Q59PcDDv5HnhW0AGuJNsyJRHNZHTM9aaeJoooh6gBXM
         O61MVPRple7C+T9bssUVyHuXx/sd3bfSCiV5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ndHuzNadjUqgmpDvF5uPWJ/dJ5KvB5Kc5N6k9RpzVlqAGrC8+IujtJjB0csK/26jSU
         nqWNmJmB4VCVQc1G7yZQ5Fo1b82eq+zIeCqADMFn00dyMVd07n34SIqeFC0sSuhrdODL
         Vm+fcxKw7gxKzkR4Dn+eR0aUXFBqzHIaFHV68=
Received: by 10.142.170.9 with SMTP id s9mr929122wfe.120.1285005496643; Mon,
 20 Sep 2010 10:58:16 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 20 Sep 2010 10:58:16 -0700 (PDT)
In-Reply-To: <4E10ACF241081344B9702AA8C6440440C5B14FB331@MX01A.corp.emc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156644>

On Mon, Sep 20, 2010 at 17:39,  <nolan.ring@emc.com> wrote:
> Where did the -t come from? =C2=A0What is this telling me?

git branch supports the -t or --track option. You obviously have too
old a git with too new a svn2git.
