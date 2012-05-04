From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Fri, 04 May 2012 04:35:40 -0000
Message-ID: <1167779eee7d442b9db0eecb347d5516-mfwitten@gmail.com>
References: <4F9F128C.5020304@palm.com>
            <201204302331.q3UNVo7o032303@no.baka.org>
            <4F9F28F5.2020403@palm.com>
            <201205010137.q411bxaU002449@no.baka.org>
            <4F9F52B9.9060508@palm.com>
            <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
            <4FA2D8EA.7030809@palm.com>
            <87obq5ggpu.fsf@an-dro.info.enstb.org>
            <7vehr1dl2z.fsf@alter.siamese.dyndns.org>
            <4FA307C5.102@palm.com>
            <4FA3090D.5080406@palm.com>
            <4FA32A6A.4070007@blizzard.com>
            <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Illia Bobyr <ibobyr@blizzard.com>,
	Rich Pixley <rich.pixley@palm.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	git@vger.kernel.org
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Fri May 04 06:37:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQAGu-0000AN-W4
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 06:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815Ab2EDEhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 00:37:32 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37677 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab2EDEhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 00:37:31 -0400
Received: by wgbdr13 with SMTP id dr13so2377954wgb.1
        for <git@vger.kernel.org>; Thu, 03 May 2012 21:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=fUxUYs10RKb9u4IMPwCAwrcLMCepWv1mSP4gAkIq0zU=;
        b=PUrI6OHhzg20IJqgctNNw5xMFK0CY/9S1NT1sHpzw4tTDvNcJL5Ypi6OA+Fe4eGUTC
         KHMZX9xITEArJxz7o9lpy9AGGEjqA6pc0NH7EMmoxJoevwGviaC+mhhUP38YNVdnYoNm
         CY8TSmTD2xqmv5rhzMhkwZhKeBbtQG1EkHnU9t5L6jSsjyXkk39Ya2zd3FAdl7Xpfew3
         f8+aznzTJXImqxvblZrU46AtYfBrpQJ7IujcnqHkCwAOu3SgfnnV54Wi38ByaPzN5Lzk
         n/HNOyefbZEjYSnxYNXHivKJQrFcWi1LToAu8sgwm1KBpK+xl8IA3om0xUVdfLcXXWwG
         D5mg==
Received: by 10.180.77.233 with SMTP id v9mr9050320wiw.22.1336106250585;
        Thu, 03 May 2012 21:37:30 -0700 (PDT)
Received: from gmail.com (lumumba.torservers.net. [77.247.181.163])
        by mx.google.com with ESMTPS id gg2sm10775029wib.7.2012.05.03.21.37.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 21:37:29 -0700 (PDT)
In-Reply-To: <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196986>

On Thu, 3 May 2012 20:13:01 -0700, Nathan Gray wrote:

> On Thu, May 3, 2012 at 6:01 PM, Illia Bobyr <ibobyr@blizzard.com> wro=
te:
>>
>> It is just a "non-fast forward" move of a branch tip. =A0This term
>> describes what happens precisely :)
>>
>> It is true, that the term is non obvious to the new comers.
>> One may google and get an explanation of the error pretty quickly.
>> First hit for "git non fast forward error" gives an explanation from=
 a
>> new comer point of view for the simplest case.
>
> I just led a team of reasonably bright people through a transition
> from SVN to git.  Not one of them understood this message.  Every one
> of them thought something was broken.  This is a very common
> occurrence, so a short, simple message without jargon for this error
> would be a big, big win.

Well, what is your suggestion?

Nobody in this thread has yet provided an explicit improvement because
the actual complaint is that the vast majority of people (including
supposed "professionals") don't RTFM; it never even occurs to them!

Let's look at the message in question:

  To $uri_for_central_repo
   ! [rejected]        HEAD -> feature_0 (non-fast-forward)
  error: failed to push some refs to '$uri_for_central_repo'
  To prevent you from losing history, non-fast-forward updates were rej=
ected
  Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the
  'Note about fast-forwards' section of 'git push --help' for details.

Not only does this already spoonfeed the reader with a suggested
command for getting back on track (i.e., 'git pull'), but it also
explicitly points out the relevant documentation and HOW to gain
immediate access to that information from the command line!

As for a seemingly conservative suggestion, how about using a little
more structural white space:

  To $uri_for_central_repo
   ! [rejected]        HEAD -> feature_0 (non-fast-forward)

  error: failed to push some refs to '$uri_for_central_repo'

  To prevent you from losing history, non-fast-forward updates were rej=
ected
  Merge the remote changes (e.g. 'git pull') before pushing again.  See=
 the
  'Note about fast-forwards' section of 'git push --help' for details.

Alas! Error output like this is constructed in the code in a way that
potentially makes adding such white space non-trivial.

Perhaps the error message system needs an overhall; rather than spittin=
g
out error messages from anywhere, they ought to be corralled and collat=
ed
by a dedicated subsystem.
