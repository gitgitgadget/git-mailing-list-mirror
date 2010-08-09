From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git and Documentation
Date: Mon, 9 Aug 2010 20:43:41 +0000
Message-ID: <AANLkTi=pk4oXz84kWbHEzTUiWkTV5P4P9mTwzQbJG865@mail.gmail.com>
References: <AANLkTik_rO_+az5kE=yhfXK1uUO3v0RKdcO2hzFBcZym@mail.gmail.com>
	<AANLkTi=P=RsToSor=giC+dgV24bPj7KJ3eRV1M5a+iuD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sultan Shakir <sshakirflhosp@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 22:44:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiZCR-0008Et-3R
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab0HIUnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 16:43:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55773 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0HIUnn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 16:43:43 -0400
Received: by gyg10 with SMTP id 10so3560651gyg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=trv8CLwGDe7sf+qdK9q3cxxrIvNAdQfRF29VoI07fUk=;
        b=ac8rcGfBO0aneEJeUa/xumBGfxQ5vToiobfF4v1vgxEMbvH7JE4UtjGDFCTDy+ZRuB
         9sKDqH4hf4O2wSOE2cyyVVQfKbQS+4nHeA9KasTEZz4YrjPVFHJ4PfSGj0Un+HVL3GWU
         RmT99Oet7tbZmjGyvl8HPczf/1gsJSAjc4nKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PQTONzvLjazba9+sSnlr8SFMe30jdLMK+xl1E0Y0zGQX1AJfTp+npG1hbrMjxY7y1x
         XCaq6zjYGhePZcAzBTA5FQEjn63ek/9KsVQGEaDgCcXBFBVm5ZFK4YPAff8peOu5BBR6
         oNJXmNVdDn7ksetmaZkH/lC0qJsevztDZI30Q=
Received: by 10.231.149.12 with SMTP id r12mr19711680ibv.185.1281386621863; 
	Mon, 09 Aug 2010 13:43:41 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 9 Aug 2010 13:43:41 -0700 (PDT)
In-Reply-To: <AANLkTi=P=RsToSor=giC+dgV24bPj7KJ3eRV1M5a+iuD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153019>

On Mon, Aug 9, 2010 at 17:35, Sultan Shakir <sshakirflhosp@gmail.com> w=
rote:
> Dear Git Community:
> My organization is exploring using Git to manage our code repository.
> We also have a strong need for documentation of our code. =C2=A0The c=
ode is
> written in a=C2=A0proprietary language (Discern Explorer/CCL). =C2=A0=
We looked
> into Natural Docs but don't think we can combine it with Git.=C2=A0=C2=
=A0Does
> anyone know of an app where we can combine the power of Git and code
> documentation in one? =C2=A0Thank you. -Sultan

Can you be clearer. That question makes little sense.

You can keep your documentation *in* Git if it's in files that you can
keep in version control. So in that case you could keep it alongside
your code.

Can't you use this approach?
