From: Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Thu, 21 Nov 2013 10:43:34 +0100
Message-ID: <CAP8UFD0n3gs0ynP8f_RgbpE4rugodcWQ_CtqvtbV0bnc9fzi9Q@mail.gmail.com>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
	<87txf6jgmi.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Ben Straub <bs@github.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Thomas Gummerer <t.gummerer@gm
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Nov 21 10:43:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjQnm-0001EA-QJ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 10:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab3KUJnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 04:43:37 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:33536 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab3KUJnf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 04:43:35 -0500
Received: by mail-vc0-f170.google.com with SMTP id ht10so4128632vcb.29
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Kkg8w0bmLArzmDk45Or0F0OajF7vdlk1EVzAJbEIzoU=;
        b=rvNP4E8LF2OCjFvQUZEBrMLMCV3JJcElH/GATCPIIP7lnZJ5LVAm7YgHWKmHeduGGa
         VrlKScl0jIMg+hOFQrR4h7hKNr6/gKurI9c9hi4g4oJKCauWSDjnZSsRAR+hfh4O1GOG
         H8mEpfMVA6LuspoAgMDxDmw87+QSudeqt2Mszwq8cuCSBNKFtrVBuWM9dE0VrNhPb12F
         cG3m3JUkOFgla19XnqP8mOsqgfWPc/8YFjPBSH/ZR8unCOd7GreWWEsTJUJsgwLPd0kA
         FR/AYW80BVpPmlR8cPRFHDhBgDSCnEKLDcqX6/4XzTRrSNQ/riub+gD9kpbt62rNCe2h
         +05A==
X-Received: by 10.58.67.9 with SMTP id j9mr5027105vet.3.1385027014814; Thu, 21
 Nov 2013 01:43:34 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Thu, 21 Nov 2013 01:43:34 -0800 (PST)
In-Reply-To: <87txf6jgmi.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238114>

On Thu, Nov 21, 2013 at 9:36 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Thomas Rast <tr@thomasrast.ch> writes:
>>
>> * Find an org admin and backup.  In previous years Shawn and Peff did
>>   this.  Would you do it again?

If Shawn and Peff don't answer, it probably means that you should volunteer :-)

> Any opinions on these points?
>
> I would actually favor a move to a wiki of the style that Peff proposed,
> hosted by github and backed by git with either a very mild ACL or none
> ("bots don't know git push").  k.org wiki had a grand total of three
> edits in the last 30 days (plus some bot edits for user creation).

If we are provided a wiki of the style Peff proposed, then I am ok using it.
But until we have it, let's use the k.org wiki.

Thanks,
Christian.
