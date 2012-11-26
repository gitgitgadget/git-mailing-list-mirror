From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Mon, 26 Nov 2012 14:17:15 +0100
Message-ID: <CAMP44s3KqCs2N0iiExyN8PGGXe72SROAuJX7xWxW1GnnpVivtQ@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
	<20121125173607.GB32394@thyrsus.com>
	<CAMP44s2fSpL13kDAm9W2ti-MERpKukNzNZ_Yt0oOOWMYOQPr2Q@mail.gmail.com>
	<20121125221126.GB6937@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Mon Nov 26 14:17:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcyZC-00053S-7s
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab2KZNRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:17:19 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53119 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab2KZNRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:17:16 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so10707263oag.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 05:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=B62ZghEu9N1h2o8WmQymVG9YaVqaWTAyhMJoJG8oZls=;
        b=bKuENxoRjkO9f93IGaFG4YQnlQ7cAyksD4VPYIqjl4fGKSazd4ITq6hUClmX9UzJGe
         /JwWv/7X+IaMRq6Q0OlgAmUALG1Frx6fUWB0xk7irYoAZ/5UYg9vhCWJFFvDghSDosaC
         1Sym83rx/2uZBhaXBEEj1V72JsPHBWBbLyJzyy1KrGHPrPB6mb62kSn6ziXimcpAqHQT
         wq7y3L8O23bfrYPaKEchnq/+xcAuMNQsQu89baAxHSrxKm/tJqbC9J/VtmEp+K+glw1Y
         4PZOV1Szajyk8UAv2ZS2IhpGGOtVerxGWR/PY0DQHN/2oXYIFdMfSh+WBHHDC/6XXuK+
         ScMA==
Received: by 10.60.28.166 with SMTP id c6mr9022737oeh.140.1353935835767; Mon,
 26 Nov 2012 05:17:15 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Mon, 26 Nov 2012 05:17:15 -0800 (PST)
In-Reply-To: <20121125221126.GB6937@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210441>

On Sun, Nov 25, 2012 at 11:11 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> And are you going to be around to spot them? It seems my patches for
>> git-remote-hg slipped by your watch, because it seems they use stuff
>> specific to python 2.7.
>
> The dev group hasn't decided (in whatever way it decides these
> things) to require 2.6 yet.  When and if it does, I will volunteer my
> services as a Python expert to audit the in-tree Python code for 2.6
> conformance and assist the developers in backporting if required.
> I will also make myself available to audit future submissions.

What dev group?

> I think you know who I am. Junio and the other senior devs certainly
> know where to find me. I've been making promises like this, and
> *keeping* them, for decades.  Please stop wasting our time with
> petulant display.

All right, you don't wand feedback, fine.

If you need me I'll be rewriting python code to ruby.

Cheers.

-- 
Felipe Contreras
