From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Sat, 18 Sep 2010 10:02:24 +0000
Message-ID: <AANLkTik50NTkA8DCzrQRR3Z+JO6++sseZqcfcCG4zQ5Z@mail.gmail.com>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de>
	<AANLkTiknoBS7x2za3qzghfS0TD6UUL83eoZz7LFBPUuc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sat Sep 18 12:02:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwuFa-00080T-Lb
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 12:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab0IRKC0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 06:02:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47778 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab0IRKCZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 06:02:25 -0400
Received: by iwn5 with SMTP id 5so2662734iwn.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WByasffgL5Nc5X32WeESPLsg/OTBC68IBpnejyxV7pk=;
        b=Yk5zTlMVcdnJqNkgSZWFcuOuq/Vya7Tt083RmqSVCKoYTBGPxbWVVzij6LWoAkgo+c
         XtQFzUPAPD13bI49H09GapJtMqZZt5tt8OnbHthlyJM8ZTBBoU9qMgarLvXptnbUfzMm
         CghVhaZnAgUYpF5Qt7YYuASvpwU1ErRN9qK/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mIaks30xss6VV4Yuh7Rg6CSo010XzgyRlTxg6LzQ2ZVmzfJqAoOsYYH9HjRMBXn/mz
         Hhq8Lh885gp0Wu+Lt7QXLphIERza0ybIphiiHLT0gYCZCLiz0apPT3JqfghkOXBDx4dy
         Fts27nL2OKl6iFR5DMSm4mf+U1LkBi29YypSc=
Received: by 10.231.35.8 with SMTP id n8mr6657732ibd.78.1284804144925; Sat, 18
 Sep 2010 03:02:24 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sat, 18 Sep 2010 03:02:24 -0700 (PDT)
In-Reply-To: <AANLkTiknoBS7x2za3qzghfS0TD6UUL83eoZz7LFBPUuc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156450>

On Sat, Sep 18, 2010 at 09:58, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> =C2=A0 =C2=A0You want to do X, and you think Y is the best way of doi=
ng so.
> Instead of asking about X, you ask about Y.
> =C2=A0 =C2=A0=E2=80=94 from Re: sequencial file naming by Abigail
>
> Your Y is encoding the name of the current branch at commit-time, the
> you haven't told us.

"the X you haven't told us", damn PEBKAC problems.
