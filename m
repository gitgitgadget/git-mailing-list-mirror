From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Wed, 14 May 2014 14:26:22 -0500
Message-ID: <5373c35e95731_56d6e3b30469@nysa.notmuch>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
 <53729b2150a84_34aa9e5304e0@nysa.notmuch>
 <CAL=YDW=jCEtfEmvO-173jpJB0f3mJ2+efihprVw+MpVjxyyExQ@mail.gmail.com>
 <5372acd699145_7e25141b300bb@nysa.notmuch>
 <CAL=YDW=W1-fDXzQJFbv0xASErzq8gtKE1K_P9FVAYCAEWdEUNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 21:37:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkezc-0000a6-3W
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 21:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbaENThY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 15:37:24 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:49814 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaENThX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 15:37:23 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so35798obc.12
        for <git@vger.kernel.org>; Wed, 14 May 2014 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=6nDVVQ4VlKzcfeEx9MqtRIXWuNNWqldXJk9By4yyiRE=;
        b=NpDwY94UBRFOZv3pukKCoO4po4OBh6tZ0+UKA4EG/gDWxZ426bnEdgrR4TkuTMkqTM
         cV4+xUmxgrdXWJ+R36DQ+LrhvFMEuXFmG2UFs4vuApH5cTAisL7c6631kJy2a+6Ak/bw
         x9it/pbjqvWeptMZWxxx3u7p/3pfLDUPn4j+npM9+t53Bu3eo6lMbSeGuq02QgAymTo3
         CSMqMplrzhgmHTCvltbxc3o1cUmSPUmAw7kayGnI8hlBnV+jUr2FdkUTvkeYzlHKfeui
         +0wT9Kipy/tLen3ti6HVTrNu099Q1AbM5LpgMmI0InzxmRyNmZFF3uBPMOjRmQ2TfgsT
         eRAg==
X-Received: by 10.182.43.132 with SMTP id w4mr5492367obl.41.1400096242626;
        Wed, 14 May 2014 12:37:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id x14sm4842421obp.19.2014.05.14.12.37.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 12:37:21 -0700 (PDT)
In-Reply-To: <CAL=YDW=W1-fDXzQJFbv0xASErzq8gtKE1K_P9FVAYCAEWdEUNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248940>

Ronnie Sahlberg wrote:
> On Tue, May 13, 2014 at 4:37 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > But if I have to adjust for saying that (which was true), what do you
> > say to Junio for saying this? (which was not)
> 
> I know I shouldn't but I will respond anyway.
> 
> The problem is about you and your behaviour. Not Junio or anyone else.

Right. So when I say something moderately aggressive (but true), I'm the
problem, when Junio says something worst (and false), he is not.

Got it.

-- 
Felipe Contreras
