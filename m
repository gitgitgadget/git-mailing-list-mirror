From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Documentation/CommunityGuidelines
Date: Mon, 10 Jun 2013 18:58:47 +0530
Message-ID: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 10 15:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um2A8-0007BK-3L
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 15:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858Ab3FJN32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 09:29:28 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:57514 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab3FJN31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 09:29:27 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so2646958ied.28
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=FABut7v2vjDszhGV7OUCpkxWDTxBJhiDqej7Fr6Vr/0=;
        b=idbZR1krLRLsbGEA94/IW48tv/UHqeX+qpUZh87ojb5VL0yl7Wg7KRNo+MwynabC+r
         btUuHOLmT+UHhDD/VWVbkR6PReP1h1L47wwZZDZCXEnEX2ssao3jPvszXUo3jj+1ckrs
         9rZmZGts5leGO/aAxj/PEFCRxmOvEXYhhZ7ay/9aq4g7fDz2g8GYFfqbFsy6kz7YLiYW
         icjtwUh71yP6rvLHSWL8+6v8nVt5Yb9jjY27Wv5OABSquiDT/O7++f7t3L2c73fxmPM1
         i+I+OQziSVgkU7ngfOg2f9Ij+MtYFtxiNuGponYlDLvaKAxtrwA5Mie/yVpF0f61oFee
         6toQ==
X-Received: by 10.50.79.231 with SMTP id m7mr3929136igx.40.1370870967101; Mon,
 10 Jun 2013 06:29:27 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 06:28:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227283>

I've tried to write down a bare minimum, without restating the obvious.

0. You do not take offense, no matter what.  If someone attacks you
irrationally, you do not respond.  This is a public mailing list, and
we are all rational people: the attacker has already humiliated
herself in public, and everyone can see that.

1. You do not take sides or vote.  Do not post emails under the
pretext of agreement: repeating what has already been said does not
strengthen the argument.  Post only if you have something unique to
add to the discussion.

2. You stop pointing fingers.  Every heated discussion requires more
than one participant, and a flamewar requires many participants.  If
you participate, you have implicitly agreed to share the blame for
whatever happens on the thread.  People can judge for themselves who
is to blame.

3. Thou shalt not commit logical fallacies.  The ones that are most
common on this list: strawman, ad hominem, burden of proof, false
cause, the texas sharpshooter, and appeal to authority.

4. Lead by example.  If you do not like how someone presents
themselves on the list, you counter it by presenting yourself nicely
on the list.  Others will follow your example, making that person's
behavior the minority.  It is far more powerful than explicitly
stating what is "acceptable" behavior and what is not.

5. We are a community of programmers, and we are here to collaborate
on code.  The argument that leads to higher efficiency and better code
has an automatic advantage over the argument that doesn't.

If someone breaks one of these rules, there's a very simple way to
communicate this to them: you don't respond to their email.
Optionally, respond to their email off-list calmly explaining what
went wrong.
