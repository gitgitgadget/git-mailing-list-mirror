From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: Improving Readability of the entire Codebase
Date: Sun, 3 May 2015 20:12:20 +0100
Message-ID: <CAKB+oNt3dsT-Ckw3=0xGWzATvYp4uh9JbwHpPX7uh88ow7rW2Q@mail.gmail.com>
References: <CAKB+oNv1q=62a0-T7CCcOAOU+sfXPiyZPMB1qWxf-8zX=4PPpg@mail.gmail.com>
	<CAGZ79kbORH6S5Cq03tRU0eHdu75QF1phZFiDsyiFQ+sg_2V83g@mail.gmail.com>
	<CAKB+oNs2iaXSSoiu4-OMT7VgSYdigU0k+gT0NMqSBw1pRZhe0A@mail.gmail.com>
	<vpqpp6hv608.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 03 21:12:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YozJS-0003jF-Cu
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 21:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbbECTMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 15:12:23 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32945 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbECTMV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 15:12:21 -0400
Received: by qkx62 with SMTP id 62so74917732qkx.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 12:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LKvnhCzo+v7uQ0FcO6UhudpYor1DHnNOHI9W8PSu6Mc=;
        b=xNxVSiugHqy4dMiOzFVtVKZqwASSpDO5qMMChJsjLxC+NpjEYXht38PpP0jtSTjzok
         WHEItKFWRIcZ+YbPBe6zd7feye5L24J0Zp17wlMbhte3xPQa7jfS2Fz7NjQvrEIGB+pq
         1TREYjAFeEkkd/g1Jkkr//qCRzVl8bH2N51D78SaSBHxq119TY+Ary9qadlU720ITOes
         Rk2ELDtVm1dx3Rjq1fVB/NVldqDt/h3eIq2KRwJqGf35/jrItcTGyEgnd+zIcMUI0/Lj
         GgQV7JDz3j1nMrxLZRdfSpFCnuvehnWrzRrXsYv7MpC2WAypAqL7wjZUlZYwX+MFw4n2
         rmjQ==
X-Received: by 10.229.96.199 with SMTP id i7mr17365474qcn.6.1430680340955;
 Sun, 03 May 2015 12:12:20 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Sun, 3 May 2015 12:12:20 -0700 (PDT)
In-Reply-To: <vpqpp6hv608.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268284>

Regards
Alangi Derick Ndimnain


On Sun, May 3, 2015 at 8:02 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Alangi Derick <alangiderick@gmail.com> writes:
>
>> Thanks so much, i am learning the community, so that is why i am
>> making a lot of mistakes. Thanks for the correction. I have started it
>> already and submitted a patch. Can you have a look and tell me
>> something?
>> Regards
>> Alangi Derick Ndimnain
>>
>>
>> On Fri, May 1, 2015 at 4:35 PM, Stefan Beller <sbeller@google.com> wrote:
>
> Please, don't top-post on this list. Quote the part of the message
> you're replying to, and reply below. See how old-timers are doing ;-).
Thanks so much. I never knew it but now that you have told me, i will
respect the rules.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
