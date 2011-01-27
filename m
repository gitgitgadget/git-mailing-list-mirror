From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/3] git-gui: spelling fixes in russian translation
Date: Thu, 27 Jan 2011 13:58:05 +0100
Message-ID: <AANLkTikbtN=fx+jVHQAMAD1R2P7o3_KTNif8SMHozWc3@mail.gmail.com>
References: <cover.1295295897.git.raa.lkml@gmail.com>
	<1c96343bbf6fb30e7453c3df7b49ea31667e0469.1295295897.git.raa.lkml@gmail.com>
	<20110117210828.GC27029@blimp.localdomain>
	<AANLkTinZCegWW-6uQ++uO9fGQ4SQ34=W4TJXW6ii5jXD@mail.gmail.com>
	<87wrltnakc.fsf@fox.patthoyts.tk>
	<AANLkTi=A=yD4Oe-meB=ZMFe_Wm8om-hmA_MOU8vyyBNR@mail.gmail.com>
	<87fwseo9f4.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Serge Ziryukin <ftrvxmtrx@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Alexander Gavrilov <angavrilov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Jan 27 13:58:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiRQc-0002nV-L7
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 13:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab1A0M6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 07:58:08 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39032 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab1A0M6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 07:58:06 -0500
Received: by fxm20 with SMTP id 20so2114187fxm.19
        for <git@vger.kernel.org>; Thu, 27 Jan 2011 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PrfdabdWZfA7YKB1usFftD0dF5r/nQvFZDd/W6Pxn2M=;
        b=qqtuWdDNfEHw5znb4LNalaID5X8vlOSxAnxbu1ULXAcY4Y6800SDc/RWohttwR4IbA
         ycqatLoAYnVplpOfReQFw9BimWCWuA413X/TK0ez0EnXD0mFQEF1tjMvZ7O+FoNXYADI
         lbRy38k9F9cBSbHyXAzZJaiy08O3k5PoIGR2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lH/rXpMuHM8Tx6FWGsCZbtTI3o0buwgseR1UGOfY3/eCB4tzT9EPSY7Yu8iRThhxrl
         BNjdXYrcPxHuiBTL2TllSbFidgXrPOMT+J6CgD3O9GXxTKCJreIE5cvBnWpF0Ge6P6p0
         vDkYP1r28RSdCkh5otFA/vaT1+s86kqPYs9HE=
Received: by 10.223.83.4 with SMTP id d4mr885225fal.59.1296133085685; Thu, 27
 Jan 2011 04:58:05 -0800 (PST)
Received: by 10.223.72.14 with HTTP; Thu, 27 Jan 2011 04:58:05 -0800 (PST)
In-Reply-To: <87fwseo9f4.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165579>

On Thu, Jan 27, 2011 at 12:47, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
>>What's with git-gui-i18n/mob branch being out-of-date? Actually,
>>it seems to be abandoned, because it does have quite a bit of
>>changes in it which are not in git-gui/master: spanish, bulgarian,
>>portugese, romanian, chinese, italian, japan and greek:
>
> The git-gui/git-gui-i18n.git repository is a fork that was created to do
> the initial internationalization of git-gui I believe. It predates my
> involvement with this project so I could be wrong.

Well, still does not answer the question: why are these spanish, bulgarian,
etc translations not in git-gui/master?

> We don't provide a mob branch but you could create your own fork on
> repo.or.cz if you intend to do much development and then post merge
> requests to this group and myself.

No need. I'll provide a link to pull from next time.

> I think I'd prefer to see forks than use a mob branch. Or receive
> patches or course.

With abundance of free Git hosting I too think it is a solution preferable
to almost everyone (that's why I suggested about a branch to pull from
in some earlier message).
