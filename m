From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv3 00/16] Add missing &&'s in the testsuite
Date: Sat, 25 Sep 2010 19:39:30 +0000
Message-ID: <AANLkTimL1d9EbcEjV9KDBuqFBG6aBRuFQoRX091j3RSM@mail.gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 21:39:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozab5-0001nu-LD
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869Ab0IYTjc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 15:39:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64151 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809Ab0IYTjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 15:39:31 -0400
Received: by iwn5 with SMTP id 5so3418976iwn.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=roNClhQjC3OxzE+YuuqoKYnqe9Xz6EOSijlkhYVPnUI=;
        b=xrQ56kMh86Sw6rm2JTVj1S3yJXDoh1v+tq5sgytq6RT3VFFcnLWIlwc2SzDDYFW1Uf
         o3rCX31VXsvzmyeAGsXwug9+vfOQTBuzE+UYiBqV10eHRKBZZIvFCPBVLqd1t/+3Q1Xt
         Z0AieIsfRqx9n89GHN/3YsmNsg1n2jBnQDwHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RUxvfpEOCtG7ixgxK162qfBKdHWh66ESOxlRcqYC6k7v00uUPMA8nhmM/FFnNdGxOS
         4K+l7MmSsqTUf9VyUERmRMvVITX4U+BhDO8ru0Zv3dOHd5OeWFeaao07WxwcL5x22+YD
         dp9Z6rgq0bUTYrr6f8a3WfnYMWvJI4v5QuWoo=
Received: by 10.231.174.65 with SMTP id s1mr5975534ibz.153.1285443570498; Sat,
 25 Sep 2010 12:39:30 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 25 Sep 2010 12:39:30 -0700 (PDT)
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157193>

On Sat, Sep 25, 2010 at 19:06, Elijah Newren <newren@gmail.com> wrote:
> =C2=A0* Made several changes suggested by =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason and Jeff

Except as noted in patch 15 (if that is an actual issue):

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
