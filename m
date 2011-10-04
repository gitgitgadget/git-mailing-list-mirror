From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/9] po/hi.po: add Hindi Translation
Date: Tue, 4 Oct 2011 10:25:47 +0530
Message-ID: <CALkWK0=wAjpUC=77E_83xJETZ6+18FvQG22+ify7gcF5FTUzxg@mail.gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com> <1317668297-2702-8-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?Q?Marcin_Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 06:56:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAx39-0003KE-5R
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 06:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab1JDE4J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 00:56:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53412 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab1JDE4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2011 00:56:08 -0400
Received: by wwf22 with SMTP id 22so182786wwf.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 21:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tIyIiSI36LDk2RqfnWKvOpFMGqPxROgMrI5NFTUV6F8=;
        b=rqw6fKdiGIikkmkaQIu6h7gWpMvV94HAjSSG0PAJJV9mMGjG5N+MTueCdYS9FVMFJI
         +LFBFUNEVFRG7Ep2I8QZDLqSs+i857wWdqVzorkzHS04TMqgsOiXZU82dRNqv26AlU1t
         61DfpIDgaqWmiZhClrVXTNzAM3bJ0M/5ZmKHA=
Received: by 10.216.133.129 with SMTP id q1mr893930wei.87.1317704167091; Mon,
 03 Oct 2011 21:56:07 -0700 (PDT)
Received: by 10.216.51.207 with HTTP; Mon, 3 Oct 2011 21:55:47 -0700 (PDT)
In-Reply-To: <1317668297-2702-8-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182727>

Hi,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason writes:
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> [...]
> Note that Devanagari rendering is broken on many applications by
> default at this time- the latest Emacs, Vim and Chrome render it
> incorrectly.

The latest Chrome seems to render it fine now.  In retrospect, I don't
see what value this paragraph adds to the commit message- the first
paragraph should suffice.

Thanks.

-- Ram
