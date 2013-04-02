From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Tue, 2 Apr 2013 23:14:49 +0530
Message-ID: <CALkWK0mgtfYFd+sT=J-hAMLq=HVF-_a-kT_xxE9-ZzfiBiFBQA@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <20130331225747.GB11704@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:46:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN5HY-0002yT-49
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758889Ab3DBRpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 13:45:31 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37494 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759325Ab3DBRpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:45:30 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so735664ieb.29
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DkLspc3xkfXpv1LbjyovnNM2s+k3P59UuKQ8Ioci6NY=;
        b=G1xeiDdU5fFfdan3Z1d2WOXYUrnE1RRoOJYoOtbsOZ+uaBU75nS8IJSJ73lFF2uRnc
         eTyKK+U6DsQrdEtJgYV9nsATWSteliIdhM/GJPh8KpiqCSjUSNeLzCBfVye+eHMkSlBY
         6mU4rEm2XAaIw14eDxrZNbacMr9w9+V9ee1mOZfaI4SrVM991Kp13OX77luVH6Pathkm
         y5SqI+Q0NDEw0ObTD2n3Yb4k815Mo5rzZpkotvvuoZnQ5UwgW4zBb8QiJZtJGZepAXyA
         yElXbPLbe4Z8MufYeP3BvR488il7yDj76yNMTcSGB9C2bm5rk0o6dpr8uCzKMVcYsW/n
         mLtw==
X-Received: by 10.50.17.71 with SMTP id m7mr5690923igd.14.1364924729662; Tue,
 02 Apr 2013 10:45:29 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 10:44:49 -0700 (PDT)
In-Reply-To: <20130331225747.GB11704@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219817>

Jonathan Nieder wrote:
> Elated is probably not the right word.  More "annoyed at being told
> their work is ugly without an accompanying concrete and actionable bug
> report". :)

If I had an actionable report, I'd have started hammering patches
instead of wasting everyone's time here.  I'm was presenting fragments
of my thoughts, hoping that it turn into concrete actionable work
after exchanging a few emails.  I'm also annoyed that it didn't
happen.

> If you are curious, at a quieter time it might be useful to ask for
> pointers to the discussions that led to the current design, and folks
> on the list might be glad to help.

Will do.  The search on GMane is no good, and taking a local dump to
search using real tools is just too painful; does someone already have
a local dump?
