From: Phil Hord <phil.hord@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 16:06:32 -0400
Message-ID: <CABURp0riKhJ1p+06aKMCnBiupg3LyVCky5XRcPNLyaJDTkip9Q@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org> <CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
 <7vip3npet0.fsf@alter.siamese.dyndns.org> <CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
 <8761zm4wzg.fsf@linux-k42r.v.cablecom.net> <CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
 <CABURp0qGYG4T+t36=Us328YdLzy9KjBOWot2gSOk=FgCRUCLnQ@mail.gmail.com> <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 22:07:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USv6h-0007Sh-NI
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 22:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312Ab3DRUGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 16:06:55 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:40231 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab3DRUGy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 16:06:54 -0400
Received: by mail-vc0-f171.google.com with SMTP id ha12so3023522vcb.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7CbsASqdTkNotDSABf1pdY4CysWeuHYAAgD/VtNy2yQ=;
        b=MnNuUZCkjrJFy+9ZJxMhsSGXP88iMcsWDD0Fz9dYaOBsXIkPVzjbUPhLQQ+ougRLQY
         iH0HmqSmVjfaxv4CQ4FQ1jNc3sYjzjgigvomJINtqpLwFqC9yh3p15ZJWi81YxviDYBy
         lKXS6d8Rr+he+GhFrdWYQsxcJDcVTcbkcfIX5sRlDZkVYIN90EaoPmsD/rZIFeN8FrFW
         UQulA1JlMNHF+oDVIrCI2AHMHGo/wiK/F3G8tcBKI17gj8F8MK19SVPxoNxCTcUVzjk5
         JjEPftaCCGnkC+0r7/9ia3G3eAxfI5/naFgxdxIXyURQRB6vA0aLmWtba4Wq1z0atsB2
         Bpvw==
X-Received: by 10.52.76.6 with SMTP id g6mr7998750vdw.13.1366315613772; Thu,
 18 Apr 2013 13:06:53 -0700 (PDT)
Received: by 10.58.219.34 with HTTP; Thu, 18 Apr 2013 13:06:32 -0700 (PDT)
In-Reply-To: <CAMP44s3pZt3QVjS7GbXqjMS4ti3p=Vs2DmFXQjsMM3rs9qURmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221690>

On Wed, Apr 17, 2013 at 2:50 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Apr 16, 2013 at 5:45 PM, Phil Hord <phil.hord@gmail.com> wrote:
>> On Tue, Apr 16, 2013 at 3:04 PM, Felipe Contreras

>>> If you want to waste your time, by all means, rewrite all my commit
>>> messages with essays that nobody will ever read. I'm not going to do
>>> that for some hypothetical case that will never happen. I'm not going
>>> to waste my time.
>>
>> This is not a hypothetical.  Almost every time I bisect a regression
>> in git.git, I find the commit message tells me exactly why the commit
>> did what it did and what the expected result was.  I find this to be
>> amazingly useful.  Do I need to show you real instances of that
>> happening? No.  I promise it did, though.
>
> Yes please. Show me one of the instances where you hit a bisect with
> any of the remote-hg commits mentioned above by Thomas Rast.

I made no such claim.  In fact, I have never bisected to any
remote-hg-related commit.  I fail to see the relevance of this
qualifier, though.

P
