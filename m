From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] po/hi.po: Add Hindi Translation
Date: Thu, 9 Sep 2010 14:57:04 +0000
Message-ID: <AANLkTimdrTHTpfbvznpEHM2p8KpxvMrfDGHwsboQtuUt@mail.gmail.com>
References: <1283971131-25106-1-git-send-email-artagnon@gmail.com>
	<AANLkTi=geJoBzDw4z-pWytCi9XmzwXvzyzFHUpVYnmMJ@mail.gmail.com>
	<20100909140205.GA13472@kytes>
	<87aanr6kol.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Antriksh Pany <antriksh.pany@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 16:57:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtiYq-00039m-Ae
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 16:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab0IIO5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 10:57:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64799 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075Ab0IIO5F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 10:57:05 -0400
Received: by iwn5 with SMTP id 5so1198369iwn.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9MI4Iru2YVnxtpwqjz45eREQ9nKozUmW4P8ZT3fHhvY=;
        b=g3Nv7eKUjd1kKmHlUP/H8jM6d6ipY2SC4slh0z9StDVc9MW8HefstyH4qvRKiMPtqU
         zteVLiNNx1Z41ewKwXQpRcGHrht56itob9VmZ6l3qR9HnMOVjgaOl5YH4J9g6PDp/75W
         igxcfgQmoAPme0husomjvhjBoTHe6e4LVOirU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oA3uqnabyPLwHUCJYPjWu57u/t9xurgFycY9FxFu2Bk4wvEcxh2OIvdH+Jopkj9m6D
         wwRVCnKbanF95huPxBhyaL/qhSqXCC0d1hyymP1Bn6A8GlpNKSuBiZuVnKmsExnpyJSz
         lFdkOuZomG3MJ/aKpvlgI5dGI8Y60KY8JX4kk=
Received: by 10.231.14.140 with SMTP id g12mr967899iba.84.1284044224238; Thu,
 09 Sep 2010 07:57:04 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 9 Sep 2010 07:57:04 -0700 (PDT)
In-Reply-To: <87aanr6kol.fsf@catnip.gol.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155861>

On Thu, Sep 9, 2010 at 14:44, Miles Bader <miles@gnu.org> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> Note that Devanagari rendering is broken on many applications by
>> default at this time- the latest Emacs, Vim and Chrome render it
>> incorrectly.
>
> Is this still the case in emacs 23.2? =C2=A0If so, can you send bug r=
eports
> about it (I thought devanagari rendering was more or less supposed to
> have been all fixed up by now)?

It works for me if I follow the instructions at
http://www.emacswiki.org/emacs/SupportHindi

On 23.1.1, and only if I launch Emacs in X, not in the Gnome Terminal,
but there fonts are GNOME's problem presumably.
