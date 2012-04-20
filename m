From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: git windows
Date: Fri, 20 Apr 2012 13:13:02 +0200
Message-ID: <CAH6sp9OqNR50S-36ByGqA9WROVBtYHuMn5SEk_r9EbmO4iWm6Q@mail.gmail.com>
References: <CAN9Ei9wZrrwfqdOVmhbDccw5XWNHwLvG5qWFE47wvHA083Ve6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alok Sati <alok.sati@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLBm3-00033f-FW
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 13:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab2DTLNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Apr 2012 07:13:05 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:45486 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab2DTLNE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2012 07:13:04 -0400
Received: by qafi31 with SMTP id i31so537380qaf.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=l2qAlZ85CukkOH92P+RhZxA7G7WqC67MjZGX3FPLnhk=;
        b=dM00SztJIdAQYHzdeF+fPQyrPmfTysDRfnF1MYnf6zxy01zv9EbemS9qOU+yTBC474
         Ku79zWw3bn7bOjt13ItcYlvJryqkGegZThGg2RK1XckgZsAEKG507ArQ1bmWnEVI8Qkp
         D/z+erFoaINm8HdUIqKDrMKrY3BorNagbvzOJqANg6FDwWSfPZWzWD3CA3435Zfcb5Jg
         T48ZAifj0cYFXjhSv0K5mfRKoRlsrkF6yQ8tDrUQ3rq2qTVIrdXI9pQusMT4b28APsd0
         X0Q83iijRh1hfRpxav4uaF25BoQwofxM6liqhRdeoXrDF5AFz9KnTkJbMLepvyye4s9z
         ExOA==
Received: by 10.224.32.193 with SMTP id e1mr1498074qad.44.1334920382545; Fri,
 20 Apr 2012 04:13:02 -0700 (PDT)
Received: by 10.224.32.19 with HTTP; Fri, 20 Apr 2012 04:13:02 -0700 (PDT)
In-Reply-To: <CAN9Ei9wZrrwfqdOVmhbDccw5XWNHwLvG5qWFE47wvHA083Ve6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195987>

Hi,

On Fri, Apr 20, 2012 at 1:05 PM, Alok Sati <alok.sati@gmail.com> wrote:
> Hi Git Team,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 I downloaded git windows version =C2=A0and i am
> able to create repository.
> kindly help me with below queries.
>
> 1 . =C2=A0how do i create users
> 2 . what would be the url for other team mambers to access the reposi=
tory.

Your questions aren't specifically relevant for git. Git does not do
user management, nor does it specifically start a server for other
people to access it when you create a repository. Of course there are
ways to access a repository over a network, and there are ways to do
user management. For that you might be interested in reading something
like the Pro Git book, specifically the chapter covering setting up a
git server[1].

=46rans


[1] http://progit.org/book/ch4-0.html




>
> kindly help
>
> Thanks
> Alok Sati
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
