From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Mon, 6 Jul 2015 00:35:29 +0200
Message-ID: <CAEcj5uXiGVvLm==s_SB7GnvBfuKi7j4yH+fgNq4JZtkvK7pZwg@mail.gmail.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
	<CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Eric Raible <raible@nextest.com>,
	Emma Jane Hogbin Westby <emma@emmajane.net>,
	Max Kirillov <max@max630.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@gmai
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 00:35:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBsVm-0002MP-I4
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 00:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbbGEWfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 18:35:33 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:33175 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbGEWfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 18:35:31 -0400
Received: by laar3 with SMTP id r3so134532915laa.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dvMRe1z/zfA6XvH7Zg+JQudZy/GKQF6z+G8YXOyNdOM=;
        b=pqIY9OWzpwQ33p0YM1QfmUVH1Bd2mUzoPXIldYhd1EIaBNqy2asoBC0pAC63DGVwYs
         idj5B1AwvdwtJXbRhbmbTA0HgiQrJhg90H1NUWvhHZmr8SeKl5FeS3Esz94xqjkytlLa
         Ehw81QIfw9qKBZ7ZNrVqfn23mhrnVUibperMwvFGQzegv1sSMvBRa9oZKT8GisFB6kok
         Sd7Z1tuJqhaBq/SEM3Pg2QiQS1QnWtvQA3N6aJqXxDbFsNl9sdI50kAKbUTQsw8ncwTP
         xJiqDbrO9g6Yz3uQ/hCorjwYtfYf97QskMnHyZpYdfX2gOb2Ezg4f8RR3Iuq/WlUUIUo
         6BJw==
X-Received: by 10.152.7.7 with SMTP id f7mr46432105laa.106.1436135729335; Sun,
 05 Jul 2015 15:35:29 -0700 (PDT)
Received: by 10.25.152.202 with HTTP; Sun, 5 Jul 2015 15:35:29 -0700 (PDT)
In-Reply-To: <CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273374>

On Mon, Jul 6, 2015 at 12:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Unfortunately, the non-ASCII characters
> in Duy's name got corrupted, and the botch is present in the patch I
> sent. Sorry. Not sure how that happened. Can you fix it locally?

Fixed [1].

[1] https://github.com/git/git.github.io/commit/b5f7d6523ca6a634d568fc9017135ff2a9ea6462
