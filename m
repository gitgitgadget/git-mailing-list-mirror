From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [GSoC] Libgit2, Summer of Code is over
Date: Mon, 16 Aug 2010 16:43:26 -0500
Message-ID: <AANLkTim92DyfsMb=qvaDz02xzhF7ZPfOy06mCGsn_Xen@mail.gmail.com>
References: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 23:43:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol7TC-0005xl-Hs
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 23:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725Ab0HPVnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 17:43:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44586 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab0HPVnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 17:43:46 -0400
Received: by gyg10 with SMTP id 10so2047110gyg.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=4cXs/889s0WyXFWz0lPDlBtWNRbLKwSLftXnqG3R4Ck=;
        b=S1sbzjxFLHo30hQp7lLsLaTQ24dRKdQ3MafUNv5wqU+pglGn6A6mNmpA4NTAWizj65
         5qBOULEj1CBpLC4tJ7YLNeGSSewKd/nxILPn/n0ZUZ0yBqE1jFobC2YTSKSTIbkIWbaO
         Riv+wFXYa6tN6Q4vNr2FD49yuVvPtXtYVy9GI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=h0BzBy5E+ZMyAlWSH5/o+cq/Pjch94qRRaJINDRgGiSYSCviZw4SbJw/UAJNPhVRBl
         EvDeT+88AYqINhbbB6rGw+DYKuTeFB9pQPhyV9EViwbBwqBLl9H3xtRHTk5DOeL82uwd
         WGzBdKG1ascpFD3gE61/mLkZ0JfRwdEIuu7xA=
Received: by 10.150.199.1 with SMTP id w1mr6237663ybf.322.1281995026170; Mon,
 16 Aug 2010 14:43:46 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Mon, 16 Aug 2010 14:43:26 -0700 (PDT)
In-Reply-To: <AANLkTinPSsTAZ9cxba2smHn1beRvchcsc7VHei2xSf_k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153678>

Heya,

On Mon, Aug 16, 2010 at 14:46, Vicent Marti <tanoku@gmail.com> wrote:
> All these features have been properly documented (regarding its
> external API) and are accompanied by their corresponding unit tests.

Wow, very nice, looks like you've got a lot done.

> The final version of the code can be found on my GitHub account, on
> the experimental branch [1].

Why is it on an 'experimental' branch? With all the tests passing etc.
doesn't it make sense to get it on a more stable-sounding branchname?
:)

> It will be eventually merged back to the
> official repository.

How about getting git.git using it? That would make sure it would
actually be usable and maintained. :)

> Overall, it has been an interesting experience,
> and it seems like the development of the library is not going to halt
> after the Summer of Code.

Does that mean you're planning to continue contributing? I would be
awesome to have another maintainer for libgit2.

-- 
Cheers,

Sverre Rabbelier
