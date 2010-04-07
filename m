From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Remove --allow-empty from the git-commit synopsis
Date: Wed, 7 Apr 2010 10:29:56 -0500
Message-ID: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com>
References: <h2h51dd1af81004060142p25194aaai58492f617419d0f8@mail.gmail.com>
	 <1270652979-23572-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 17:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzXCw-0000yG-Mw
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767Ab0DGPaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 11:30:05 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:53851 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab0DGPaA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 11:30:00 -0400
Received: by gxk9 with SMTP id 9so703764gxk.8
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 08:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=B+yHZDkYxFVxSDIe4MEYC80K5abFpihWyq5wo5PxM9c=;
        b=nVPoXZIUEIOUgiI5C4U1TLbePs546DGLXM56Jq6kcYduCZYo5n1S2J+EntArpU6dn8
         H5vpzKobE5tAB0/OZfwcAWai7mqwHhqSRPy6kkLqMIpL1Dh8SaYu/nZsKMSmSmEntWv5
         9bLVPzJHaCYdJ58HRrAPj7JP/8y+D439noTzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WpAKx3BDKJ0ihrtcnAuR/c9nhfXyfWXqYMUhSbhoQVM73nRnjHW390W6K5/wJlFmgQ
         b2Ddr6liTwtE3eOi1zvRpOxcQaDrfTAE3d5QTfGSqV1+e1UfrHGJiVX4X0Pidkm2XqOu
         R7pCiW91KBpHCM2zYai27CZ3mtib3yIYwUyhc=
Received: by 10.100.206.13 with HTTP; Wed, 7 Apr 2010 08:29:56 -0700 (PDT)
In-Reply-To: <1270652979-23572-1-git-send-email-avarab@gmail.com>
Received: by 10.100.200.4 with SMTP id x4mr19867212anf.125.1270654196459; Wed, 
	07 Apr 2010 08:29:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144237>

Heya,

On Wed, Apr 7, 2010 at 10:09, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> --allow-empty-message option (see 1aadbfad) by Jeff King

The hash of that commit is likely to change before it is included, so
I'm not sure if it's wise to include it here right now, unless Junio
is willing to make sure this reference stays correct?

--=20
Cheers,

Sverre Rabbelier
