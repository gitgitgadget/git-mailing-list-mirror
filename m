From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Sun, 5 Jul 2015 23:13:54 +0200
Message-ID: <CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
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
	Paul Tan <pyokagan@gmail.
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 23:14:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBrEv-0006BG-NK
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbbGEVN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 17:13:56 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:33178 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbGEVN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 17:13:56 -0400
Received: by wiwl6 with SMTP id l6so268243486wiw.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BxJnj6Q7Vhe2lGxAE6IykQkyYui3HriFhyGED23lOjw=;
        b=jN2PqOiAfUV79p1y5xjv6W3q72thF/HY2W4v2Ph9MOwe2C1K0Oi+Tt8plMFExx4B2W
         Q9ErA77vTXas8lVApR/lAcx3qIFfE7pfJHxIe4b0/goW3pGJMPZHswDhREemc2FggFi5
         7/DA3XsDiEUQeMRIcSqPZ+mxrHTpaXG73107z+uwDoBV8Lb021llZg2glOD1aGb+xEaV
         DZz9vdD5AlKJ2xZ2ELaahcOsohIACadIAu+rkycVMNu6z8zy0YA3xdYDWU4zoKaegJ63
         OXxLlilyXHfBFNPuLHxwrlfeuS8Q9YIzYfWZh2uy2MjegdOrIrW4sVLmAPyi9OMK04L1
         AK4Q==
X-Received: by 10.180.211.237 with SMTP id nf13mr46246489wic.90.1436130834876;
 Sun, 05 Jul 2015 14:13:54 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Sun, 5 Jul 2015 14:13:54 -0700 (PDT)
In-Reply-To: <20150705191101.GB9815@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273371>

On Sun, Jul 5, 2015 at 9:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jul 05, 2015 at 01:13:57PM +0200, Christian Couder wrote:
>> A draft of Git Rev News edition 5 is available here:
>> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-5.md
>> Everyone is welcome to contribute in any section...
>
> I'm not familiar with the criteria for deciding what merits mention
> in the newsletter. Is the recent introduction of git-worktree and the
> attendant relocation of "add" and "prune" functionality worthy?

Yes, I think it's really worthy, thanks a lot for contributing this
very interesting article!

> If so, perhaps the following write-up would be suitable?

Yes, I changed a few things to make fit better with the rest of the
content, but otherwise it looks great!

I created this PR to discuss the changes I made:

https://github.com/git/git.github.io/pull/85

Thomas just merged it, but we can still discuss it.

Thanks again,
Christian.
