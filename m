From: Kevin <ikke@ikke.info>
Subject: Re: Links broken in ref docs.
Date: Wed, 31 Oct 2012 12:17:01 +0100
Message-ID: <CAO54GHC-rBV-RnZ+69W8sROE+TOZ14t-D9Xq4PyEZNP7yLJnHA@mail.gmail.com>
References: <CAJr+XPGm4djBh+vacG5Ff=Y6aYmWbcUXOV9x2jekgnsGsk4b-g@mail.gmail.com>
 <CAH5451nFf_SY4K2DS52vhP6VeXSmeikUrc0zy8HK3xmGgs+UGg@mail.gmail.com>
 <CAJr+XPETQ2Jifns3_dfoB-sLLru2=Jkofb5RrBxLE4Fa9Aqp7A@mail.gmail.com>
 <CAP2yMaKzLHiqpUtfcNtSFo8aqnbvS9RvCzC-DZvQMBgXvte5jw@mail.gmail.com>
 <CAO54GHBvWoqZRbDwhQnmjGsBLKfGiv-JTpAakrAjiqEXYHHXPQ@mail.gmail.com>
 <CAJr+XPE17vbqKJuJ4DfjPVfhzvL7B24eJJU-ipqUi3R+7p_yig@mail.gmail.com>
 <508FAE23.4080704@ira.uka.de> <CAJr+XPH4MTg_F_YuT=R1mLVwOUYPB0US3w2mZ1+DDvrQV7vVfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
	Scott Chacon <schacon@gmail.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	git <git@vger.kernel.org>
To: Mike Norman <mknorman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 12:17:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTWIk-0007JZ-57
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 12:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055Ab2JaLRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 07:17:24 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59776 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964985Ab2JaLRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 07:17:23 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so4094293wib.1
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=XQyGSSUTsr5AKhaXiNAUD2iWsF5qdheHzv02gV8yLRc=;
        b=Iv8wnTaGDzbgYK0t9EYsUCQJ5n9rha8jKcoHg2ZyoH1KHIL2RfHY+9bFOBYPRQNCv/
         6iDdXTqt85aYU4Qj2IcLcsUIu9xqMfmoBBJFbo/c0cPhqU9wm67U87/3bX2QchM53cLE
         iPDdpYxYBi7J8Ji7gpPncrGn+69qoDU5dvs04cC89yrqN0CWlbUYLJ+Tk/lzedEuOP60
         mrlwgt8iao0nuZorQ7zgZAOgKXI0VqPb8apqjcMAVvhgCieh45DuhDhqNE5NNzHADqyH
         MULslOqQcoklHSv5txyCWgKWAQCoeLYCNCVpPjd2C5947RYc2uZltg9R0O68oKFHOQ1o
         f58w==
Received: by 10.216.214.209 with SMTP id c59mr18328486wep.214.1351682241649;
 Wed, 31 Oct 2012 04:17:21 -0700 (PDT)
Received: by 10.227.29.101 with HTTP; Wed, 31 Oct 2012 04:17:01 -0700 (PDT)
In-Reply-To: <CAJr+XPH4MTg_F_YuT=R1mLVwOUYPB0US3w2mZ1+DDvrQV7vVfQ@mail.gmail.com>
X-Google-Sender-Auth: 6WhGhVhR8AkG8ykChbP92eXQjOE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208806>

Looks fixed here too

On Wed, Oct 31, 2012 at 12:30 AM, Mike Norman <mknorman@gmail.com> wrote:
> I just checked and the issue seems to be fixed! Clicked around on a
> bunch of previously broken links and they work!
>
> On Tue, Oct 30, 2012 at 3:38 AM, Holger Hellmuth (IKS)
> <hellmuth@ira.uka.de> wrote:
>> Am 30.10.2012 09:07, schrieb Mike Norman:
>>
>>> Not seen any recently. I'm guessing the dev is in the path of
>>> hurricane Sandy? (Not sarcasm, btw.)
>>
>>
>> Do you still see failures? I checked out the website just now and it seemed
>> to work flawlessly (at least the links I tried, could not find any Sharing
>> or Updating section). New design since I last visited, more end-user polish.
>>
>>
