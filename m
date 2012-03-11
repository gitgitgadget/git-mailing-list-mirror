From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Re: Trouble with file specific merge strategies
Date: Sun, 11 Mar 2012 12:27:55 +0100
Message-ID: <CAMXnza2KeDB+=59jduBWc9_6xD0qaOXSx2psX0pYDY+LwqTX0w@mail.gmail.com>
References: <CAMXnza3SLHWLsFkYLhkJLAwtP2n=QVTXZ__GSL-CvajxC6i0Dw@mail.gmail.com>
 <7vk42rzfab.fsf@alter.siamese.dyndns.org> <CAMXnza12HVFdmji7k-b-G43NWmobqCQEwXZXB=VxJA=tatqX-g@mail.gmail.com>
 <7vd38jxu5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 12:28:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6gxF-0003VC-1K
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 12:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371Ab2CKL2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 07:28:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63833 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2CKL2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 07:28:15 -0400
Received: by iagz16 with SMTP id z16so5191912iag.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 04:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=QXd8TlD+7GyTa55QscBGdEzHG67kSA7vJGAJWUzP8cw=;
        b=MZfnUwQ7ceQiTjzZxSlUc1/NkaN/2Tm+z/RjPQDSCd3wUvtko0DrOwD9UWirqUyKWs
         8kQ8olgF5clv4tUzUD2yg7ekodK9zHAAET6NTM6/1xTMfMwKxhVzborHKweickTrZaBL
         lGVNvncI0mCsJIn+oVwQwFpvK+xzN6Da9y6m2aOROEcEaB0T3zqgE8yT6KaPSBNK+vVM
         jVDcW4VfNZO4D0i5GGbw6o5DCVL+rByncTcq/O5Boi+ZY05tJE3OM9ARbPIPKWMceM7t
         hFqyOomx+i3TOVBZnCXyHAWpaHopbVDSIwApxRXLNH+Ap76QnvS02CXc1PzYSJo61abT
         TpEA==
Received: by 10.182.89.65 with SMTP id bm1mr4040011obb.52.1331465295152; Sun,
 11 Mar 2012 04:28:15 -0700 (PDT)
Received: by 10.60.20.104 with HTTP; Sun, 11 Mar 2012 04:27:55 -0700 (PDT)
In-Reply-To: <7vd38jxu5b.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: OLevoEeq0RvXVvMB3eZ3ZhC_sPo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192809>

Hi Junio,

On Sun, Mar 11, 2012 at 12:18, Junio C Hamano <gitster@pobox.com> wrote:
> suvayu ali <fatkasuvayu+linux@gmail.com> writes:
>
>> ... is that discussion on progit talking about
>> something else?
>
> Sorry, I do not read or write progit, so I do not know offhand what
> it says in the section you read and I cannot judge if it was you who
> misread, or if it was book that misspoke.
>

Okay, thanks. I'll switch back to the tried and tested,

$ git merge -s ours

I'll take up the progit issue on the relevant discussion boards.

-- 
Suvayu

Open source is the future. It sets us free.
