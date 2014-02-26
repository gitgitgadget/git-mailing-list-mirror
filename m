From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 12:24:13 +0100
Message-ID: <CAFFjANRqKqq_f9SCR4vP3YKUpfk1J2RQdB9G4gnY2OcZivzhXQ@mail.gmail.com>
References: <20140225154158.GA9038@sigill.intra.peff.net> <CACsJy8Bw7JqokgGt46T7Xivk08F-DS4Dj-j1PWxoStu=cVzo5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:24:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcbP-0000h8-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbaBZLYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:24:35 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:44949 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaBZLYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:24:34 -0500
Received: by mail-ve0-f181.google.com with SMTP id jw12so1961763veb.40
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Lwzvv0Zh2pg0kHundjWKqG0yjSazhkwZ0dzq0kJcmQU=;
        b=d2xLloZIbByBg/rdVWpZIdhQeSMxLHKxGWzclg0tzeFyOleLiT4ED8Dja318ZHvkRS
         a77WAeO5K9VIjwB7LQA5ZoXELue7EaxSEOqhmQBbQEd+Y70D0w8WrnaTAcyXE/PxWEDm
         s1IqjUBYl25c3iJRdsr73OsF9ohSpyxMk09NK8cwSagF1BhMvxHWBHzQLfODsRHYwrEj
         JAVwQ+DhZubZg1FoMdV2R9QY/lH3xIDrvwkD2zd8Tr9n7lSkNuqgVnyD4q2eNjg2emHV
         dB9/AYb29m9BCkNfs3+fY1vCNfdMLx7YUc0dLeYgr7XQ5QdmNYny6taoNQ1aRywCR3p8
         XMzA==
X-Received: by 10.220.114.135 with SMTP id e7mr924472vcq.23.1393413874053;
 Wed, 26 Feb 2014 03:24:34 -0800 (PST)
Received: by 10.220.133.73 with HTTP; Wed, 26 Feb 2014 03:24:13 -0800 (PST)
In-Reply-To: <CACsJy8Bw7JqokgGt46T7Xivk08F-DS4Dj-j1PWxoStu=cVzo5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242723>

On Wed, Feb 26, 2014 at 12:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 25, 2014 at 10:41 PM, Jeff King <peff@peff.net> wrote:
>> I'm pleased to announce that Git has been accepted to this year's Google
>> Summer of Code.
>>
>> Student proposals will start coming in on March 22. In the meantime
>> students will be reading our Ideas page[1] and enquiring about the
>> program on the mailing list and on irc. There are many ways that
>> existing git developers can help:
>>
>>   - continue to add to and polish the Ideas page
>
> One thing I noticed after tg/index-v4-format is both libgit2 and jgit
> do not seem to support index v4. So we could add "index v4 support on
> libgit2" to the idea page. It's a relatively small task though once
> you get a hang on index format.

That sounds like a nice task for the Summer of Code too, specially
with the current effort to make Index v4 more visible in Core Git.

I wonder if anybody from JGit would also be interested on mentoring
for the equivalent task (index v4 on JGit). I've CC'ed Shawn Pearce.
