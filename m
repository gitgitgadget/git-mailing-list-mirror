From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 2 new messages
Date: Tue, 18 Nov 2014 15:22:19 +0100
Message-ID: <BEECE0DF-BAE9-4131-89A5-91453E7C04D8@gmail.com>
References: <1416153257-2407-1-git-send-email-phillip.szelat@gmail.com> <CAN0XMOLPN6ojrpR5VWw7jCwe-L6N8EELXyiSmkzsyBMPjmjxCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?ISO-8859-1?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
	=?ISO-8859-1?Q?Magnus_G=F6rlitz?= <magnus.goerlitz@googlemail.com>,
	mackyle@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 15:22:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqjfu-0007F5-Oa
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 15:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbaKROW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 09:22:26 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39008 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbaKROWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 09:22:24 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so1960146wiv.17
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 06:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=k13JicSe5WqdBo3tB3iDO46/PzTzb9sdHeQA7LQV5vE=;
        b=FReXFMCFffW4005PQexsDEWKnlurDLZTvhdCK9Ie2i1B4f4yO8LlTTXVUgzWyAL/NI
         7YkEIe3fE3GirzCllJU4fmSor0FNg9B465jC/61yl+IWNdBT3ZV9v2lo8/SfamfBluOB
         Z3+mMaau7tsElKRaX+w2UwDY53jAC8kxapzZmy8x+rPqZcV+G9DbGiScaJ5PiWbU1pl9
         56ZpW2KUaxyFOpc/3T3IxBNnxm6jcFXzzHwngrooEMs/CaO0R2Haww+zILzbYxd8Ar5f
         l3wcJn8XYcuCz5FmhGFt3m81qRbl6xCRqQSgFXlvJvsxpR78RyyPazxq5EVZ2OKwC/++
         7hPQ==
X-Received: by 10.180.9.103 with SMTP id y7mr4451803wia.5.1416320542785;
        Tue, 18 Nov 2014 06:22:22 -0800 (PST)
Received: from android-b7bb6bce7d91de53.fritz.box (i577AAF79.versanet.de. [87.122.175.121])
        by mx.google.com with ESMTPSA id wm6sm56028422wjb.5.2014.11.18.06.22.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 06:22:21 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAN0XMOLPN6ojrpR5VWw7jCwe-L6N8EELXyiSmkzsyBMPjmjxCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Hi,

>There's no need for writing your name in the commit message
>body.
>

I know, it was a mistake. 

>Your message has a different style than other messages of this
>type. I wouldn't address the user directly and would write it as:
>
>msgstr "ebenso Pakete und alternative Objekte betrachten"
>
>What do you think?

Yeah, I must learn that. You're suggestion is okey then.

>
>Hm. If I understand it correctly, "check" is one option of the
>--recurse-submodules
>parameter for git-push, the other one is "on-demand". Since the
>possible values
>are either "check" or "on-demand", we shouldn't translate this string
>at all and
>should just write "check|on-demand" as shown in "git help push".
>
>Perhaps this message need to be adjusted and excluded from translation.
>I dunno.
>

Okey.

Thanks for your reply.

Phillip
