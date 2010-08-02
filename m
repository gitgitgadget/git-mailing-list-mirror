From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: URL substitution and config file precedence
Date: Mon, 2 Aug 2010 17:46:24 +0000
Message-ID: <AANLkTimf+T9_W4oMjj+vujr+oDXwEuNO4OyjO+oRtV05@mail.gmail.com>
References: <20100802153720.GA28481@fishbowl.rw.madduck.net>
	<AANLkTikdyNjcgZpY=BPjkieacDXHPvp0he77VJZCMLpw@mail.gmail.com>
	<20100802173853.GB5325@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 02 19:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofz62-0005RW-98
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 19:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab0HBRq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 13:46:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39615 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab0HBRq0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 13:46:26 -0400
Received: by yxg6 with SMTP id 6so1343811yxg.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=51nOvNxJ3rDatRirwkJIVwnPdeDuXJak/OF6kUZ0KSI=;
        b=sWePJ74OoWF/YQ2lMflJrzYV0JPsklO8PajnARw/KhLeh2DDRyD2j6WDMYiBcXpJu0
         /dsZiDnrCKyCnmv7eXq48v/kjDBa2uLZj0IHcLAfh1CZ1Ehkvcke0NBBHMlwqZkw8ihY
         bBhwJhlxt6uW+qn+zWGgqHeNLs4K/AYDxMgdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=geZZVV2OpzUDzwI1qN3e6OKjfOyXTWdLPiz4XQ5DNmI9XuigiwtYNsn+dUWb6K4JaC
         a7J4W357W7tj9yJsIvCb1dQDXIfOKTyJhoM/Oa61GsoAu97pOvRmjkNuyKB2QmLGvdNp
         OXgowN2ebwOUTReYVzctf9U+/gzmBfB51NveY=
Received: by 10.151.150.2 with SMTP id c2mr3020692ybo.255.1280771185027; Mon, 
	02 Aug 2010 10:46:25 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 10:46:24 -0700 (PDT)
In-Reply-To: <20100802173853.GB5325@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152429>

On Mon, Aug 2, 2010 at 17:38, martin f krafft <madduck@madduck.net> wro=
te:
> also sprach =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>=
 [2010.08.02.1805 +0200]:
>> I don't know, but it usually helps if you add the person who added
>> the feature to the CC-list.
>
> Yeah, I didn't check. Does anyone happen to know who that was,
> saving me the excursion into the history? I don't have Git cloned on
> this laptop and I am on a really bad link. :(

Daniel Barkalow added it back in 2008. Adding him to the CC list.
