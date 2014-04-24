From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Wed, 23 Apr 2014 22:58:29 -0500
Message-ID: <53588be5192d5_59ed83d30824@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <alpine.DEB.2.02.1404232050340.14881@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Lang <david@lang.hm>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 06:09:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdAy6-0001Tg-8s
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 06:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbaDXEI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 00:08:57 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:46521 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbaDXEI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 00:08:57 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so2035098oah.24
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 21:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=AfKZtTU7TXseYrrTgJSgTs5SJDx1E9TOdtnsQmBjpU8=;
        b=ReJjn/K03JAfuqAA37Kee4JzZ1EsxM91n5Ncqyi6S/fMniQ3ZfP5WyvjgbsXkbINvZ
         yRot1LuY1WYASrRggYJFFygQzskkI/c6jZ0JCnRyp941IyKDRfgzJGg+ORseGeJEmnof
         /I0AgHCqZn2ylDN53+eOmrVyGbWfHamMJX8NNHlyC5Ed+3C5V0UpJrLiWyMZY0UGPnh+
         Ib7m98iABcCcP93cWOPWLHR2Jkg/A0J5Revt6qMKxyVvfK+lPL329i4UDd2QsNB8JCDZ
         V+dVG/WrCsrMQsmsIClJsLFF8c4P2DGdFMWm7gTzUhzhuV9QFiWSNsh3vJNySlcWSElg
         Ws6Q==
X-Received: by 10.60.150.143 with SMTP id ui15mr114542oeb.50.1398312536646;
        Wed, 23 Apr 2014 21:08:56 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id 10sm6068391obq.18.2014.04.23.21.08.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 21:08:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1404232050340.14881@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246934>

David Lang wrote:
> On Wed, 23 Apr 2014, Felipe Contreras wrote:
> 
> > David Lang wrote:
> >> agreed, of all the things that people complain about regarding learning git,
> >> the fact that the commands are words instead of cryptic 2 letter
> >> abberviations is not one of them.
> >
> > It is when they start to use Git seriously and type them a lot.
> 
> If that was such a significant factor, nobody would use Java with it's horribly 
> long function names.

There are these things called IDE's where people don't end up typing the whole
function names. Take a look.

> People are far more bothered about all the switches to remember and the options 
> for them than they are the fact that they have to type entire words.

This is, again, a red herring. The fact that B is more important doesn't mean A
shouldn't be done.

-- 
Felipe Contreras
