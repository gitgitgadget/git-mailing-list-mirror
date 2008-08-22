From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [JGIT PATCH] Typos in documentation
Date: Fri, 22 Aug 2008 17:08:49 +0100
Message-ID: <e2b179460808220908j37bda30exaf74be35221dad35@mail.gmail.com>
References: <d03b5675d55bbbd68e3d22b6b28b1f70f7af00b9.1219418949.git.mike@abacus.co.uk>
	 <20080822155928.GG3483@spearce.org>
	 <20080822160038.GH3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 18:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWZD0-0000MW-M0
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 18:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYHVQIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 12:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbYHVQIu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 12:08:50 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:35341 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbYHVQIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 12:08:50 -0400
Received: by py-out-1112.google.com with SMTP id p76so369804pyb.10
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mJr47lRg56QCSHnUTa7llB0vK9/F3WQ13vEQSk5HSrQ=;
        b=UdlVNXsT/EyHr/54HgSkLINDgH8MRizpubRwkB/Lhq8eXakiXXpeN4M6i1cUXmAygZ
         TbDZv6wlwrc8yZK+mfgoP2jAp28JZW7YGvFFlQWc6nfGjdOWkUI/GHgscYYpx2SMmIX0
         8ZnwTcRY284eZNjWp6dkREyGj+142rJJntSRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WE958S4JYNhY0MG70v/RBvMKl2M8znL6W5ZZmq83zzWvoj+DT/XonrqWHC1TggdsQm
         YT7UVieqqOMxAYERRixTD51hpSQKMJQDQI4Oth4MLC3NUEVFeB8hWOBudw5RSnHiY18N
         h+IeVrLOkh7nL0Y1EjBQRgQbcyZTZqQhEEPiA=
Received: by 10.140.201.15 with SMTP id y15mr615146rvf.145.1219421329020;
        Fri, 22 Aug 2008 09:08:49 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Fri, 22 Aug 2008 09:08:49 -0700 (PDT)
In-Reply-To: <20080822160038.GH3483@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93322>

2008/8/22 Shawn O. Pearce <spearce@spearce.org>:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
>> Mike Ralphson <mike@abacus.co.uk> wrote:
>> > ---
>> >  EGIT_INSTALL |    6 +++---
>> >  README       |    2 +-
>> >  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> Thanks.
>
> I just noticed none of the patches have an SOB line.  Mind if I
> forge it from a prior typo fix you gave us?
>
>  Signed-off-by: Mike Ralphson <mike@abacus.co.uk>

Yep, that's no problem. They did sort of have a signed-off-by line
when they left here, but it seems it might have been mangled by either
rebase, format-patch or send-email. It's been sucked into the headers
because there was no blank line in the (empty) commit message. Sorry.

Mike
