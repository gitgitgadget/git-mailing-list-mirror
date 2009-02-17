From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH 2/2] Google has renamed the imap folder
Date: Wed, 18 Feb 2009 08:14:25 +0900
Message-ID: <43d8ce650902171514w7b2a5b69y96f0674ce9b38c0a@mail.gmail.com>
References: <200902171012.15755.johnflux@gmail.com>
	 <7vprhg52ne.fsf@gitster.siamese.dyndns.org>
	 <20090217185423.GK18525@spearce.org>
	 <bd6139dc0902171104x55637f8fr87a9f56154a7b45a@mail.gmail.com>
	 <20090217191618.GL18525@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:16:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZAR-0001R8-Pp
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbZBQXO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbZBQXO1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:14:27 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:56097 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbZBQXO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:14:26 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1199924ywh.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 15:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bhQ35isAJcDMwOLcfHx2S/L694V0pOTBSdcDBuRlxkE=;
        b=o4Tkj2Fpa94MkahjFevUxqHDe+if5kTLygfeEZFi49KXk8PWWgwfh24SVYHFHxajuN
         eAJciidLYkq3783uuuJK2AJUExzDfGvxUbbe8SC9/rR2kUCA2a05ac+NVVSjeZ1d96Fm
         hTVno8qIbbI61XGd0466pSfsODgB4mW3Am03k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bcvOzwZrQ8FbAHucRF8kj0s7nn8EjltUIVH6ihllag68tkzkHJCAC8syqSnXqL+VgR
         BQaqAXlk/jV2awCvUF/mCWfqtx0Kj8O3QjkwEv+LykC1P9oUsG+aQTk/0EuxYYSYbhAP
         f5ACHZqZHdoPNLAtqHQiG8uJCsMmXOJX89a9o=
Received: by 10.150.189.9 with SMTP id m9mr218654ybf.187.1234912465273; Tue, 
	17 Feb 2009 15:14:25 -0800 (PST)
In-Reply-To: <20090217191618.GL18525@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110471>

2009/2/18 Shawn O. Pearce <spearce@spearce.org>:
> Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Tue, Feb 17, 2009 at 19:54, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > So there's your "Gmail insider", at least from my perspective,
>> > I really can't confirm either way any better than you can.
>>
>> In that case, doesn't it make sense for countries that are "Google
>> Mail" branded rather than "Gmail" branded (I think Germany and the UK
>> are good examples?) have the "[Google Mail]/Drafts" folder, and
>> regular countries will keep using "[GMail]/Drafts"?
>
> Doh, that may very well be the issue here.
>
> I didn't realize Gmail was branded differently in some countries.
> But I wouldn't be surprised if that happened.  And if it did, then
> I'd expect it to follow through in everything, including the IMAP
> folder names.

They were sued in the UK by a company that had already registered the
trademark "gmail" iirc, which is probably why they are using Google
Mail here.

I think leaving it as GMail is a sensible idea, adding the comment to
try Google Mail at the bottom.

> In which case, [Gmail]/Drafts is probably the more common one
> seen in the wild by users, but a handful in the "other places"
> may see [Google Mail]/Drafts.
>
> --
> Shawn.
>
