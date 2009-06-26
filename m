From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Fri, 26 Jun 2009 13:55:50 +0300
Message-ID: <94a0d4530906260355r2d50fe0s244659599177c8@mail.gmail.com>
References: <200906252122.51737.jnareb@gmail.com>
	 <200906260932.43826.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>,
	David Aguilar <davvid@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 12:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK968-0001yv-MJ
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 12:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbZFZKzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 06:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbZFZKzt
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 06:55:49 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:51397 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbZFZKzt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 06:55:49 -0400
Received: by fxm9 with SMTP id 9so2017883fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0swZBlEAfzAeTp43h2P/jflqTDdA9PZUCrQ+vq4RMZM=;
        b=W0ktC4UxNJAenR/3bdwDIg831OcbkyFebeZBmr9jR7GV4/9TQYg0YYu+LHU7K13NpD
         6prkk/O5JT1Z8o/5rF+GIxKv1NnA/+awXhRK0+luNIkVxsNFfNUZIMQRlbAKQNXUbQDX
         w/Pz350TQQcnaFtKX2GlSAuNU8E1LvHOtxEB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ix200B2pTxipd+A7Whl5Ii/CQglCelpZbKKEC2T9vjSPEtfnRfe+1L0s76tw4Bo5gi
         cMKaP0RabK6mv/AyViBxfFeC+eFDcuINO0OGdOlH5BT8nZJ2ue59oxzEACeRyiuhMwb9
         Al40bkE6TcZS8vEdWWO1PBOXg/mfWUdcWxszU=
Received: by 10.86.31.18 with SMTP id e18mr3602380fge.72.1246013750985; Fri, 
	26 Jun 2009 03:55:50 -0700 (PDT)
In-Reply-To: <200906260932.43826.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122289>

2009/6/26 Johan Herland <johan@herland.net>:
> On Thursday 25 June 2009, Jakub Narebski wrote:
>> Current version of survey has 30 questions, as compared to
>> 60 questions last year; the number of free-form essay questions
>> were also greatly reduced.
>
> Good. :)
>
>> The *test* version of this year survey can be now found at
>> the following URL (as in previous year, we use Survs.com)
>>
>> =C2=A0 http://www.survs.com/survey?id=3D2PIMZGU0&channel=3DTFN2Y52K7=
Y
>>
>> Please tell me what you think about questions and about selection
>> of possible answers in single choice/multiple choice questions.
>
> There seems to be some unnecessary overlap among questions 11, 16/17 =
and 18.
> Examples: I found myself ticking off equivalent options like:
> - 11/gitk, 17/gitk and 18/"gitk or other history viewer"
> - 17/"git gui" and 18/"git-gui or other commit tool"
> - 14/"via git-bundle", 15/"git bundle", 16/"git bundle" and 18/"git b=
undle"
> - 11/StGIT/Guilt/TopGit and 18/"path management interface"
> - 17/"git reflog" and 18/reflog
> - 17/"git stash" and 18/stash
> - 16/"git difftool" and 18/"mergetool and/or difftool"
> - 16/"git mergetool" and 18/"mergetool and/or difftool"
> - 17/"git rebase -i" and 18/"interactive rebase"
> - 16/"git add -i" and 18/"interactive commit/..."
> - 16/"git filter-branch", 18/"git-filter-branch or cg-admin-rewritehi=
st" and
> 18/"git-filter-branch or equivalent"
> - 11/"editor/IDE VC integration" and 18/"integration with IDE/editor"
>
> Some of this overlap is probably unavoidable, but I think some of it
> (especially between 16/17 and 18) can be eliminated without compromis=
ing the
> survey. Maybe we can integrate the non-overlapping parts of 18 into t=
he
> other questions, thereby further decreasing the number of questions?
>
> BTW, 17 is just a continuation of 16, AFAICS. Is it possible to just =
repeat
> the column headers (to break up the table length) and still keep it a=
s one
> question?

I agree, I found myself clicking on gitk multiple times (4?)

--=20
=46elipe Contreras
