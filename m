From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git-scm.org bug: Broken link in git-push documentation
Date: Sun, 24 Apr 2016 22:05:09 +0200
Message-ID: <CACBZZX5B0n9we_-mcHhnQJ=b4nc=j9P=0WSm+tf2fNnyPJU7hg@mail.gmail.com>
References: <CACBZZX6aMXzs04DuEiQNtH1Y27s4V4=-7u8HwtuZ=PoADTFOtw@mail.gmail.com>
 <vpqfuuau6ck.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Scott Chacon <schacon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Apr 24 22:05:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auQHv-0000oh-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 22:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbcDXUFa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 16:05:30 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35405 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbcDXUF3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2016 16:05:29 -0400
Received: by mail-qg0-f42.google.com with SMTP id f74so70038797qge.2
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QJDIeGDg7njGHhykX+5I1BGNbEX29bpLQP0c33v3WgU=;
        b=XacbuWXft+4AZ+uIlJ6QwdmWh3pVekVD8eKx4S3trKZ8q7y3LcfKutZjZ8trbz93M/
         kUkvNFfY49m1aBfx/wEmwvZGFjRARJ1XmIdwhYWG4l81Au2pl+7SI8xy24OXLLExjoHs
         xMo5VJmof53hLEQpT+Nt7oDrQRb8X1K3XmxjlPhgKxSUeNQTc0Tanb6ZJEdnr8RhF4VP
         HJ340XLPxs2kxHmhrHBz7oDiUgGphs+4NqMyohELdP4/8coDu65LCqMUAvJ+2HiBS37T
         FstU8oJ4UzxgQAD/28ef/buefPUAlpxU3l+MbA2GUS1WPe0v2nbH/EJTnKtuvMTeIcJz
         vhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QJDIeGDg7njGHhykX+5I1BGNbEX29bpLQP0c33v3WgU=;
        b=UdY13+AGDtcJmgvVUEcJc2oeVA7qSYo8FVXcY/i9ZNSBqyFIMjASsIYxnYZbpR4EQh
         kNOa5N0eBDwt4+sxsIuCptHw5g/4snMn//jD1Aeonr4o3uAn7wvp+zESzpwdhXkeYX81
         5Vmnxypb4lmMYaKa+R4qRuSCSOi0lu1/EyOR/+o6fcQ9dyX9YuA/Dbrk5zNuP6rOx+Vv
         Kko3u30stVDjWK70dbR54/P/XPavK3VZSlUDlNg3tffHl0iAMGLjcdSUOhUpVYS/M93e
         mWrBcbh8XZbo8kd/88AUus9hjL33SSRDhN2mthDlU5JEAuVejK7578PqFq7Y6EIXYed1
         WZgA==
X-Gm-Message-State: AOPr4FUoHnuo9QZr6gqbCVrE/9wtHL1vSQkeu3GH1nH6SJEE79Ki5aFhYEzKe3yuY8/ELJNChujxVvpLzCGDsg==
X-Received: by 10.140.155.19 with SMTP id b19mr4375857qhb.14.1461528328999;
 Sun, 24 Apr 2016 13:05:28 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Sun, 24 Apr 2016 13:05:09 -0700 (PDT)
In-Reply-To: <vpqfuuau6ck.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292437>

On Sun, Apr 24, 2016 at 9:58 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>> I couldn't find a way to report git-scm.org-specific bugs
>
> You can do so here:
>
> https://github.com/git/git-scm.com/issues

Thanks. I didn't find that, filed: https://github.com/git/git-scm.com/i=
ssues/749
