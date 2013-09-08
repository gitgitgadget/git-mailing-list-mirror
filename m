From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sat, 7 Sep 2013 20:18:09 -0500
Message-ID: <CAMP44s2b6jFcVpdkQi5F3CWwYin6V-n==x0xSW4otsuYiW-+3g@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
	<CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
	<CAA01CsqNKMqExq1PYanotzQ-wTcf=7c5BQ_49xGu4QasXSCoeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Drew Northup <n1xim.email@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 03:18:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VITdy-0005lS-Qc
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 03:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab3IHBSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 21:18:11 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40813 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab3IHBSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 21:18:10 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so4033671lbi.29
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 18:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g7IWTddRyikWIqCU2WZQUCP17ZP7s+gRoorfYSqOcnI=;
        b=rX53azVbYyyEb3FzvCReobuBpuqThqlufidzgvLznriIGPfPa7nV7rqmUNZm10xXdb
         AUGn0xX6dEiViFynElRQ43X/oN3KKrScoZOIMjMvCUNiSyjAqMhtZMvFfRpMFYfZKJMi
         ZxkprTKlRxMoTxXsL9rp7OLY5Eb83F9NA8Wiy3t8jxuvmm01J3DHLPPzBK2D1Xsluxop
         sYll760alBOAVhU3CoqyC5XWKLMIWbOqkOcl8F2QS4FwxOtcq+/rAbw7z1dSpMSDYgWp
         WShu4B0wlfZ2qAYLLXcE8ms/yYJIu79SpM0hrPy56KpSsW2w/YGMcqb4au8w/lZSeSxp
         ns6w==
X-Received: by 10.112.168.170 with SMTP id zx10mr9591930lbb.0.1378603089145;
 Sat, 07 Sep 2013 18:18:09 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 18:18:09 -0700 (PDT)
In-Reply-To: <CAA01CsqNKMqExq1PYanotzQ-wTcf=7c5BQ_49xGu4QasXSCoeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234157>

On Wed, Sep 4, 2013 at 2:13 AM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Just wanted to point to a Dr. Dobb's article from Monday:
> http://www.drdobbs.com/tools/getting-started-with-git-the-fundamental/240160261?pgno=2
>
> The author does not use the use the word "index" at all. Instead he
> writes in following way:

Same goes for the ProGit book, which is quite famous:
http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository
http://git-scm.com/book/en/Git-Tools-Interactive-Staging

-- 
Felipe Contreras
