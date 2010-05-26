From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 4
Date: Wed, 26 May 2010 13:01:21 +0200
Message-ID: <AANLkTikMulA_5YMjyIxiFKm6Avd3tohNUxs_Bjfk08Rd@mail.gmail.com>
References: <AANLkTimFqlbYz6BL02N7UiAsGDpspFJTrLwQYWOMi-vS@mail.gmail.com> 
	<AANLkTimu5d2ofkjERW8zcgIGqsnbnGazsDaltL1r6n6H@mail.gmail.com> 
	<AANLkTims7CyMUwBb6kBUuheuZerKrlyx-e1zpeaTCvkx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 13:01:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHEMz-00029V-J8
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 13:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab0EZLBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 07:01:43 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:34045 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851Ab0EZLBm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 07:01:42 -0400
Received: by qyk13 with SMTP id 13so8870424qyk.1
        for <git@vger.kernel.org>; Wed, 26 May 2010 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=FPHklMw+KwNiXLnOJhF+t3t7O6/QwG3g4e+GIFbaKrk=;
        b=p1ZYyy0n2WDeKFE0lqCQfBItAZb/AKFIJTeXclvhw7QD2IWzcgcGd2TBQyO+5GaWvb
         HBPchYalrBd/XBZWB49Q49gxCAYP4Wwv2n2WkMx7Ar3FzdAsIIHErvhjEN6xeg+TtATU
         gnJHZ5+mqRE5GFuFFXK/IbR7pgtkEH4RnlyFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=t7tNhCAYqSL8Y+umc3fEddTgI+vfhBoDdh1PBulmmvaBBWf6E4AFl1E6MvL3a//hCz
         IrO0pNw/FkUnlkg98hdiJCh0EkeagXse9HJgViBEZJeZB89N5NnBFWNMq7wx5F/SbfrL
         yGNEp7UYnu3HgCWbfkhzIzKpRSbT/njkjQsrU=
Received: by 10.224.60.20 with SMTP id n20mr4740148qah.279.1274871701201; Wed, 
	26 May 2010 04:01:41 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Wed, 26 May 2010 04:01:21 -0700 (PDT)
In-Reply-To: <AANLkTims7CyMUwBb6kBUuheuZerKrlyx-e1zpeaTCvkx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147791>

Hi,

On Wed, May 26, 2010 at 12:33 PM, Nazri Ramliy <ayiehere@gmail.com> wrote:
> On Wed, May 26, 2010 at 10:50 AM, Nazri Ramliy <ayiehere@gmail.com> wrote:
>> Would it be able to automatically convert an svn repo that started
>> life without the trunk/branches/tags hierarchy, but was added
>> after-the-fact?

This project is still at its early stages. While this is certainly a
desirable feature, we have to get a lot of other things done before we
can implement this.

> Sorry for my ignorance, after googling around I think I've found what
> I wanted (svn2git).

No issues. It'll take another 2 months before this project can be
tested by the public.

-- Ram
