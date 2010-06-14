From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Make the Git tests emit TAP format
Date: Mon, 14 Jun 2010 23:16:50 +0000
Message-ID: <AANLkTinsD3WVpldxSS2K1Gk05D87nQv_rA3D-BjlBXGD@mail.gmail.com>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
	<m3631lp9oe.fsf@localhost.localdomain>
	<AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 01:16:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOItk-0003eE-Sx
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 01:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab0FNXQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 19:16:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42899 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab0FNXQv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 19:16:51 -0400
Received: by iwn9 with SMTP id 9so3846371iwn.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e98DQabs5iUAekOX+h0swvLgQ4+JDrxqzhAn7pRP1Qg=;
        b=dhnHKua9ZBMc8rwToBjbQLd2jmBBICAts7EhjeL4PmpqNRf1Gz61PbZGKxYATmBKZY
         xY3cQoDZ8jXolTrdDcvSJCqbAjjhdDosTUT0VJLs0+XJ+V72MuG5zsX9Rh4TZ/WajFPE
         DOpqRx6s8Ls3v3OBDdGX9zfhluqTPjH81wvHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZxSL/RPOqQotVTiWvx5MKUFRpxtkyBdHuke9C86stCRH1/x9TLYFjBEq/N2QeNI4b7
         kb7dPEdgdHxAP/jhSqTjx+5BVNI+ImYkz5gOOYSrZ1E2wFR1/hu4Sh/hD51RfBRENqBv
         LsdKolD87R57tfs78uG+AUy5vgqZyHKkMzuj4=
Received: by 10.231.124.5 with SMTP id s5mr6975659ibr.195.1276557410830; Mon, 
	14 Jun 2010 16:16:50 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Mon, 14 Jun 2010 16:16:50 -0700 (PDT)
In-Reply-To: <AANLkTinHrf_ZuuoMXlL8BFqm3UhRYxrV4t2Nmp5QNjrE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149146>

On Mon, Jun 14, 2010 at 22:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Mon, Jun 14, 2010 at 21:49, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> I'll re-submit a version of the patch with a better commit message
> which addresses all of the below.

Since the series just made it into pu is that still wanted or needed?
