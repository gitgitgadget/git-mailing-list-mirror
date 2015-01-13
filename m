From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] format-patch: print format-patch usage if there are no arguments
Date: Wed, 14 Jan 2015 00:52:27 +0600
Message-ID: <CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq387eed30.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 19:52:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB6Zs-0001lg-Ml
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 19:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbbAMSw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 13:52:28 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35410 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbbAMSw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 13:52:27 -0500
Received: by mail-oi0-f41.google.com with SMTP id i138so3781591oig.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 10:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xI0deyntHy9nQM8O/zBGtM8FMy+b/AIRYYDqWzSkqbc=;
        b=K9wJ5d71LvI0mswFoTLe1GCFWRi2quofm/w1zRpfh9aFnwQopUCzOJR4DA2R7kKBFc
         whQ194UdgN9GHp8dZB0Z2BQDNdmS45NsPgjMUctzSaUBAEog3voLRZ9J0bybPMwgCg6/
         KYN7jFJ10qQy+KzfAeoRO2zxbA+9uL2gBVYB/JXs34JwUldYIImJ1bkFjsCsMDxr9Vs1
         yIy3Z3Vp3HEtCnlYkIwEVDwtHbYbj7iPEJyUBp0jABwJNUfW65oRuV+XiTrBmpg/ke6C
         mjGrwsfGjdiVbvLk1orV5BKN2FLbCjT3OtHkLzx71hoClec+7z6Vxyp9lLvWCmzRAD8m
         6DtA==
X-Received: by 10.182.125.72 with SMTP id mo8mr22047449obb.61.1421175147363;
 Tue, 13 Jan 2015 10:52:27 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Tue, 13 Jan 2015 10:52:27 -0800 (PST)
In-Reply-To: <xmqq387eed30.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262348>

Hello Junio,

As some commands does it when they are executed without arguments,
like git config, git blame and etc...

2015-01-14 0:43 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> Why?



-- 
_________________________
0xAX
