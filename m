From: James Denholm <nod.helm@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 09:03:23 +1000
Message-ID: <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
References: <535C47BF.2070805@game-point.net> <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com> <535D4085.4040707@game-point.net> <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <535D6EB1.9080208@game-point.net> <535e18cdc7bce_338911e930c72@nysa.notmuch> <87bnvl6bdg.fsf@fencepost.gnu.org> <535e8e4253196_45651483310b3@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 01:03:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuaM-0007hb-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 01:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908AbaD1XDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 19:03:39 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:57760 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbaD1XDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 19:03:38 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so6409966pbc.35
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=6rsuXXRuOgnWnnhtJsUWPaIXpIC9KRRRToul4Fpefxk=;
        b=vMnZURCtSJOb4xS8oyAY3h/kUMjOAGVxtCNZTCD+1ai6g1JwaCOuy6HwjICHquHhFS
         e5ms1RWAfS5b1lk3s9BsRmL3hAWrSKYxFSxfmjvGnZbfOqhIakWJJaPR45AJ2LCCex5t
         fUGrEdLQ5cfr0thQz2ubDtE4jotjM9NTtvuqY8ZhQhv6oIvz+gFNwv+U9muvvmWCuzAa
         K+JJ/bg5mspkId8HRDpPIXxppSbncs2GBHtPqCpDd/CH8jHAB/2K1fvAsv6q8og2N72G
         uqKJl80bHfZmzy4X1QZ6AluqELFRze963uct9aNIh3erSvnqtOrMxWef1k7ozC4sZU1L
         4hXw==
X-Received: by 10.68.171.193 with SMTP id aw1mr28289819pbc.117.1398726218367;
        Mon, 28 Apr 2014 16:03:38 -0700 (PDT)
Received: from [10.85.182.0] ([101.119.29.89])
        by mx.google.com with ESMTPSA id ov4sm37394329pbc.46.2014.04.28.16.03.35
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 16:03:37 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <535e8e4253196_45651483310b3@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247490>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
>David Kastrup wrote:
>> It becomes easier to actually change things when communicating in a
>less
>> abrasive and destructive manner.
>
>That would make sense if I was the only one with the itch. But I wasn't
>the
>only one, so anybody could take the patches and send them in a less
>abrasive
>maner.

It's not anybody else's job to take your patches and drizzle them in the
honey of respectable discourse. They're your patches, nobody else is
going to champion them for you.

>The fact of the matter is that the tone doesn't matter, the patches
>don't get in because change is not welcome. Period.

You neglect the possibility that your personal view of what git should
be differs from other people's. One's views and values aren't correct
just on the virtue of that person having them, and you are no different,
Felipe.
