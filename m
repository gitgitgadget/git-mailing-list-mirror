From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Draft of Git Rev News edition 1
Date: Sun, 22 Mar 2015 21:52:58 +0100
Message-ID: <CAEcj5uWcybmPbbXNHgSAj=0yi4GjR+-VW744+i1+Gg2p_3g4wA@mail.gmail.com>
References: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
	<87lhipnupj.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dongcan Jiang <dongcan.jiang@gmail.com>,
	Jeff King <peff@peff.net>, Doug Kelly <dougk.ff7@gmail.com>,
	Bharat Suvarna <bharat.bs84@icloud.com>,
	Kevin D <me@ikke.info>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 21:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZmru-0005QN-EP
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 21:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbbCVUxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 16:53:00 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:33515 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbbCVUw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 16:52:59 -0400
Received: by qcbjx9 with SMTP id jx9so92719349qcb.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VfGjmQ1t7ZZH51j8N1+6KiU3c//luowQZ0kXCEDH/jg=;
        b=sO5qkCVXxuLnRuygXbwHOQrN98z78poP1xgfhCOVLF6SNMey7/QqCn45jvl/elI7KV
         b6B/UrPPmipyOZhiWP8G41oqHOQHm8DRUo09op+wSTHZ0HPXkZmBNBmQl03+3oC2akIT
         liBixbM5m2k+kSzaD0Rw3uqQ//0VzxDO7FAmweZkk6aO6Nmo9+NSujr9z2mR3fdVVeah
         BLZyhgLfP6n69ag17jmN3Cjd6oh/wxb14kNkaud0GzPzzzUK9RG2wn3kBmB84SuC8k0w
         6rz1pMzOHDheZtwx0FrYDkKiJD6JsDu4l+Ab71rZO78bKyiJSQulrPHi7kzOMsfTOpIH
         VCRg==
X-Received: by 10.55.31.91 with SMTP id f88mr147310639qkf.91.1427057578599;
 Sun, 22 Mar 2015 13:52:58 -0700 (PDT)
Received: by 10.140.102.55 with HTTP; Sun, 22 Mar 2015 13:52:58 -0700 (PDT)
In-Reply-To: <87lhipnupj.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266093>

On Sun, Mar 22, 2015 at 12:21 PM, David Kastrup <dak@gnu.org> wrote:
>     David Kastrup (dak at gnu.org) previously reimplemented significant
>     parts of "git blame" for a vast gain in performance with complex
>     histories and large files. As working on free software is his sole
>     source of income, please consider contributing to his remuneration
>     if you find this kind of improvements useful.
>
> Thank you very much for this heads-up.

Do you have a link to where people can go to donate/contribute? I
searched around a bit but couldn't find anything.
