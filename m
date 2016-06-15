From: ZhenTian <loooseleaves@gmail.com>
Subject: Re: I lost my commit signature
Date: Wed, 15 Jun 2016 18:36:42 +0800
Message-ID: <CAGrdoOrJEVtgmUQNYQh3MKMyBYGE6otSyHDJORfXMy0G-Ctjkg@mail.gmail.com>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net> <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net> <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
 <20160614094121.GA13971@sigill.intra.peff.net> <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
 <CAGrdoOoxphU0tRjV22yduXrhmOSyCc_zVnhuO9fFA6UPRd9WiA@mail.gmail.com>
 <20160615043450.GA3975@sigill.intra.peff.net> <be771366-00a7-6c20-2623-5fa54b8e19b7@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 12:36:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD8Bp-0006I9-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 12:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbcFOKgo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2016 06:36:44 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35362 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbcFOKgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2016 06:36:43 -0400
Received: by mail-yw0-f171.google.com with SMTP id z186so16072460ywd.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ObSdI4Z85nAYenAM0iF+cHsEu00H8hkwZq5NXmO9+bY=;
        b=xSzk7likBP4XjzVrhpyy56odiGpQnWydY3ihCht4nD7YDr6dZM+gLUP4LTX3ERSX5C
         f2tQfJ/xuQS4CSQqFHFOB3uFBeHrZhY22nt+Bb/pTtjlzsXcrLUR1Ia1ePQS3WIpSr3O
         1tGLTeCeJGFiQG1fZbGSqrT8WItZeF7ktzDveJShlDJ9UK6kqY7n1oYWqog8fS1QzWAm
         nf6BoHZEMBOqgwgJd9GeS9OV14YjiuTbDHKjYglD6YEF7LirtB0KiWPaKmj6zPpekzIC
         vV5UdopTcTiWBDJGkD4qUNUVxuBWqh4FDHqNh8Pfqp5Uxckd2rTYEN4ThHKmYzmtPm3c
         3lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ObSdI4Z85nAYenAM0iF+cHsEu00H8hkwZq5NXmO9+bY=;
        b=bDsMnEoWASYcQEJkTvlOK5L1QmlYa58rqHgRN0iFUd+s4OgjbW4fMP6osOnEKdS6Bv
         E1pD/k+1E8drlyq9NjvFActGOrXr6VmZoLbgMajTkc+sPUoTNagQL23H5NkTANyk2wES
         VPu/4MjT2xnD+Z5GqZNNSYiVuZLJWehbxO/wLBCKqRLavISrl2Wm3xbPMPUCjnvDtmbB
         Y1VfeAS1/hiywFEnxELYB8vYKkLJbVqhTM3hloxH/nmF80PQjTsQwNGkEgrca+ApAvpC
         mU959+tF3z+FqylXJsWg0MH3DooERwXptxdcJV/tBYpNTeB3XnrbjgA8/NdO7YVxzuPu
         EmAA==
X-Gm-Message-State: ALyK8tKqrqH1J1+VAYstA13Etaeah5DdE7wi29eFZc0ipw7yzKPiVJaQYOEXtcr4KuWm8c8Uamp9lt0QBmGu9Q==
X-Received: by 10.129.153.8 with SMTP id q8mr4423436ywg.227.1465987002869;
 Wed, 15 Jun 2016 03:36:42 -0700 (PDT)
Received: by 10.129.85.203 with HTTP; Wed, 15 Jun 2016 03:36:42 -0700 (PDT)
In-Reply-To: <be771366-00a7-6c20-2623-5fa54b8e19b7@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297363>

Thank you all very much!
-Schr=C3=B6dinger


On Wed, Jun 15, 2016 at 3:07 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jeff King venit, vidit, dixit 15.06.2016 06:34:
>> On Wed, Jun 15, 2016 at 12:27:15PM +0800, ZhenTian wrote:
>>
>>> I got two more lines from gpg -v during commit with -S:
>>> ```
>>> gpg: writing to stdout
>>> gpg: RSA/SHA1 signature from: "2EF2AD6E Tian Zhen <tianzhen@honovat=
ion.com>"
>>> ```
>>>
>>> after I commit, I push it to remote, but someone had pushed before =
to
>>> master branch, so I pull on master branch(`git pull --rebase`), the=
n I
>>> check my commit via `git log --show-signature`, there is no signatu=
re
>>> in it, so I commit it with --ament and -S again, the signature is c=
ome
>>> back.
>>>
>>> I haven't check signature before push, because I have checked four
>>> commits before, every commit is fine.
>>>
>>> I don't know whether the `git pull` influenced signature or not.
>>
>> Ah, so the problem is probably that you had a signature _initially_,=
 but
>> that it did not survive the rebase. Which makes sense, as rebase wou=
ld
>> need to re-sign.  It does not by default, but you can tell it to do =
so
>> with "-S". Or you can set `commit.gpgsign`, which should sign in bot=
h
>> cases.
>
> While it's clear that a rebase invalidates the signature, we could tr=
y
> to be more helpful here, especially given the fact that (with our mod=
el)
> you can't sign a commit afterwards any more.
>
> commit.gpgsign signs everything, but there should be a mode for
> re-signing signed commits, or at least a warning that rebase dropped =
a
> signature so that you can --amend -S the last commit.
>
> Michael
