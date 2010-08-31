From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 16:05:49 +0000
Message-ID: <AANLkTimrsiqCOKKQ6+GFdk8Z_A65mjFT0O2SB4PZ8Keo@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<20100831153214.GI2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:05:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTLS-0005v8-Uc
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab0HaQFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 12:05:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41193 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab0HaQFv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 12:05:51 -0400
Received: by fxm13 with SMTP id 13so4024698fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vVmTvoeUCcXEKVSVHLjxa4RjXhzVqOeWF7VczvAk/Pk=;
        b=xv6QXBqQVIwGlRlCT+SCRJZdkugAkEUYPzqWJEPJqIkfQp7go8gHTcC30pAAiXH5Ve
         XZaYxPTxU2LDoAGoxaDK+geUfAztmM3x3RYgl9D4srsdw0UvKvrDpoDKwSJG4gYlti53
         SA5u+a/fZ+iw8IZYUqQgHnctBsMf9mif6cI/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Yi3puvj0NMEFq000xrVt8f8KcWDrbHIfzsTazSBlaCMrrHlv977Fp657LZTjBKTFhB
         NQmoQypxPwryyXfsW8UeL2j6f55MHb2y3uye2LsfIsb3/kFBa2YYj2QA+uqVdZmU3cXX
         6ap+LiRee3qzx/W8W5kyGXNEMbpXRiZhKUZhQ=
Received: by 10.223.117.14 with SMTP id o14mr1089471faq.5.1283270749908; Tue,
 31 Aug 2010 09:05:49 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 31 Aug 2010 09:05:49 -0700 (PDT)
In-Reply-To: <20100831153214.GI2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154929>

On Tue, Aug 31, 2010 at 15:32, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Now that Git has the infrastructure for translation in next I'm goin=
g
>> to start submitting patches to make the main porcelain translatable.
>
> I've written some comments on specific patches; the rest looks good
> to me.

I'll try to reply to them all.

> Thanks for moving this forward.

And thanks for your continuing efforts in reviewing all of this.
