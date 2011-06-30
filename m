From: Mike <xandrani@gmail.com>
Subject: Re: Undo last commit?
Date: Thu, 30 Jun 2011 20:48:34 +0100
Message-ID: <BANLkTinLMez=nv4fTcFWtqRb01231sMT1g@mail.gmail.com>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
	<m31uyrutx7.fsf@localhost.localdomain>
	<20110619003718.GA5628@elie>
	<201106191237.55825.jnareb@gmail.com>
	<4DFF382A.5030206@micronengineering.it>
	<4E09DDAE.30801@ira.uka.de>
	<BANLkTimZN4swfY13zMjkCbAc9UsGSix02Q@mail.gmail.com>
	<BANLkTim459-Jx2R9GpBdkck7PMAEbamJeA@mail.gmail.com>
	<20110630183830.GA4294@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 21:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcNE8-0006ls-S3
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 21:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754100Ab1F3Tsg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jun 2011 15:48:36 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37860 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab1F3Tsf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2011 15:48:35 -0400
Received: by qwk3 with SMTP id 3so1277770qwk.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1+R9hLhEHnGWJUp7hvDlLcus/n2LYouXLxdiXZ8IgIw=;
        b=PCWyoS1MwtHpiQDIYDd2jWlpqYlsvStMJA7qI2jbv8IlZPUGkNtvt5zZ3isiS40Ap0
         YHSWprYor31Rukl3FnppHW6Cxu5voKzKA+QZiRHEll7Y0VHKuETOhpXNvk9Iv9CzWhUA
         aXy8R2qrzKDGGPF1eo6T4OnAMHAOgrvTpdgOY=
Received: by 10.229.105.95 with SMTP id s31mr1877071qco.228.1309463314881;
 Thu, 30 Jun 2011 12:48:34 -0700 (PDT)
Received: by 10.229.39.78 with HTTP; Thu, 30 Jun 2011 12:48:34 -0700 (PDT)
In-Reply-To: <20110630183830.GA4294@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176505>

You have a great attitude to design (especially that of software).

I love it when people take feedback as a positive thing, and not as a
criticism! :)

2011/6/30 Jonathan Nieder <jrnieder@gmail.com>:
> Ramkumar Ramachandra wrote:
>> Mike writes:
>
>>> I do think that git needs polishing in this way. It was designed by=
 a
>>> very intelligent programmer... however they can sometimes be the wo=
rst
>>> at user interface design.
> [...]
>> Git is
>> very complex, and changing one little thing requires us to think abo=
ut
>> how it'll affect everything else.
>
> Oh, dear. =A0No, I don't think these things are true at all (or at le=
ast I
> hope we act so as to make them not true). =A0In its history, just lik=
e Jakub
> likes to remind us now and then, git _evolved_. =A0To make it better,=
 it
> should be sufficient to do three things:
>
> =A01. When there is a small, obvious change that can make something
> =A0 =A0better, do it.
>
> =A02. When there is a small, obvious change that can make git simpler
> =A0 =A0and more flexible (so other changes can become small and obvio=
us),
> =A0 =A0do it.
>
> =A03. When there is a big, possibly advantageous change, try it out
> =A0 =A0locally (e.g., on a branch). =A0If it turns out to work well, =
use it.
>
> While it is always nice to see people thinking carefully, none of the
> above necessarily requires thinking about all of git at once. =A0In
> particular, (2) suggests that any feature leading a well informed
> person to say "Git is very complex" is a bug.
>
