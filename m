From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Could someone give me a copy of git internal api document?
Date: Mon, 26 Sep 2011 16:42:43 +0800
Message-ID: <CALUzUxqth=P+fKnP3+w=dRa4Nue588wUNrTF6ArwgxHzLkknJg@mail.gmail.com>
References: <CAMocUqREFHdqFGR9c_3hFJy6KxUaXLnaY9R+4K04mL42-KY-Kg@mail.gmail.com>
	<4E802872.2010906@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?5b6Q6L+q?= <xudifsd@gmail.com>,
	=?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 10:42:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R86m2-0007UZ-RJ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 10:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab1IZImp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 04:42:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40608 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab1IZImp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 04:42:45 -0400
Received: by fxe4 with SMTP id 4so5864576fxe.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+v5h49YyImOLHELhmTOqFtc8nlLvvEiy7j4hMlN7bGk=;
        b=rE8URM44a1o9IJOXVv6cq35RcAu4GeEOXvWLjqAw8eaBxtpkH7QUob7tNHw5VBitEU
         6iFcOz7C59mcRuJIiEOfZfm9FkAzrrEruJfuEdSSruenMAbOkBJfR++LCuw+wvFybw3m
         zSexjDjKkpSIFHmYo48enyNlm2+NPEQXF1XxA=
Received: by 10.223.53.78 with SMTP id l14mr10161714fag.140.1317026563893;
 Mon, 26 Sep 2011 01:42:43 -0700 (PDT)
Received: by 10.223.79.65 with HTTP; Mon, 26 Sep 2011 01:42:43 -0700 (PDT)
In-Reply-To: <4E802872.2010906@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182096>

2011/9/26 Michael Schubert <mschub@elegosoft.com>:
> On 09/26/2011 09:11 AM, =E5=BE=90=E8=BF=AA wrote:
>> I am reading code of git recently, and i want to know some internal
>> api in git, so i googled "git internal api", and result is
>> http://www.kernel.org/pub/software/scm/git/docs/v1.6.5.9/technical/a=
pi-index.html
>> but kernel.org was down for maintenance, and i have no idea when it
>> will recover, could someone give me a mirror url or post me a copy o=
f
>> it?
>
> If you got the code, you should have Documentation/technical in your
> source tree.?

If you prefer the generated HTML output:

  https://git-core.googlecode.com/git-history/html/technical/api-index.=
html

--=20
Cheers,
Ray Chuan
