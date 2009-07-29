From: Scott Chacon <schacon@gmail.com>
Subject: Re: Pro Git Book
Date: Wed, 29 Jul 2009 08:38:49 -0700
Message-ID: <d411cc4a0907290838r228aaa18yb748fd97d4be01d2@mail.gmail.com>
References: <d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com>
	 <m34osv3kah.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBZx-0005DO-2U
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbZG2QAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 12:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbZG2QAY
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:00:24 -0400
Received: from mail-yw0-f183.google.com ([209.85.211.183]:50850 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbZG2QAY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 12:00:24 -0400
X-Greylist: delayed 843 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 12:00:23 EDT
Received: by ywh13 with SMTP id 13so25890ywh.15
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oAC2PjscK3uuIHzR3XW4KEjqKjRy6s5VFiGAtlf/3QQ=;
        b=DQUZ+KekE6yIDE+URYYKj+WcfbJA56ti6vAtMC9w7309OQFTcLLLI09FsAXFkFtkLC
         Xd3lT1oahqMoZ+QIGTt2lwg4JtA7t/a/P5etCJDl+SBpleJo1Ct+t1qiERE+zD7Qmgre
         5+PAJFceUlx6TP4us9Ox06zYYxnLz283Z9flo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B+9vmNUbAq/UFNCJE3HMy8e7WaitRa3owWSrlc4CQEaee2fzckpITHKRcwlmEHvV4d
         xbycQjTbF9Wm9C/oiW0L2Fez7dnOC/siPEi8jVkTr0fTNSthQe3dRr1faGF019T42rE9
         nXoBGKgl/PMlEHTDlgGjlr89TLIYi/GmJFb4Q=
Received: by 10.100.141.15 with SMTP id o15mr12093205and.20.1248881929464; 
	Wed, 29 Jul 2009 08:38:49 -0700 (PDT)
In-Reply-To: <m34osv3kah.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124363>

Hey,

On Wed, Jul 29, 2009 at 2:34 AM, Jakub Narebski<jnareb@gmail.com> wrote=
:
>
> Wonderfull news! =C2=A0Thanks a lot for publishing it under Creative
> Commons (CC-BY-NC-SA 3.0) license for all to see (and improve).
>
> I'll send a few comments later (BTW. would you prefer to have it here=
,
> or private?).

You can either email them to me or fork the markdown source
(http://github.com/progit/progit) and send me a pull request or patch.
 Or just push fixes to your fork - I've been checking them pretty
often since people are starting to translate it on GitHub.

>
> One comment about on-line version: it might be better to have one
> chapter and not one (sub)section per HTML page. =C2=A0There are some
> sections that are not enough to even fill one single page.
>

I agree that some of the pages are small, but I like being able to
point someone at a section for help with something - a whole chapter I
think would be overwhelming.  Eventually I'd like to possibly add a
commenting system inline and having one per section would be a lot
more manageable.

Thanks,
Scott
