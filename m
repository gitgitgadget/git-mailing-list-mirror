From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH 2/2] howto: Eliminate all tabs
Date: Sat, 03 Aug 2013 22:20:20 +0200
Message-ID: <91d7a6c4-f7c3-4688-a7e3-a36ca3cf6cb4@email.android.com>
References: <20130716180158.GA7524@bottich> <cover.1375288760.git.halsmit@t-online.de> <4d37bfa3326469ab5b7cdbf0018f7aa671c2d74a.1375288760.git.halsmit@t-online.de> <20130731165425.GC11219@bottich> <7v8v0mvezw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junio@vger.kernel.org,
	Thomas Ackermann <th.acker@arcor.de>
To: Junio C Hamano <gitster@pobox.com>,
	Dirk Wallenstein <halsmit@t-online.de>
X-From: git-owner@vger.kernel.org Sat Aug 03 22:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5iJr-0006ok-0e
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 22:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130Ab3HCUUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 16:20:51 -0400
Received: from mail-bk0-f42.google.com ([209.85.214.42]:55007 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab3HCUUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 16:20:50 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk14so569774bkc.15
        for <multiple recipients>; Sat, 03 Aug 2013 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=o3byOidy6zojejMl3kjL7gu7AWMAv+ZLD6aXPVO9EXE=;
        b=FZdsZzHocaLhkLhV6hmtJ86JDx0EiyrF/fTliOso8CLTkHndRfgUZe93Cj96yycmot
         0lu7vWPR0ACPhY//l7GxzoCHYAPPtdocsIEcLHZGevEst78Dsa0vIbaYvQGVrzcxHLbm
         hS40pAjtv989KDMWxidOxufmA7twDP/9lFqyIBMCbWD+jqsqwOtgtF2AXK2tXUijb65r
         E7wGjQagGFOBZ/pQvPdHeeywt2U4Pi4or0ZukKYyuQAGeMGNpzTwsWHO2gdijpLeEu5D
         mFbTs17wSPvQ9smou3Lsg7hmprxUYiyrDcWuRV6jjyOFyHXyMNJZWVUnBfBZLy6el8yE
         /ZKw==
X-Received: by 10.205.4.197 with SMTP id od5mr1909551bkb.1.1375561248894;
        Sat, 03 Aug 2013 13:20:48 -0700 (PDT)
Received: from [100.106.128.40] ([46.77.124.110])
        by mx.google.com with ESMTPSA id ct12sm3205011bkb.12.2013.08.03.13.20.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 13:20:48 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <7v8v0mvezw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231615>

Junio C Hamano <gitster@pobox.com> napisa=C5=82:
>Besides, the tab width of our source is 8, period.  Get over it.

Isn't the howto documentation intended (mainly/also) for the users of g=
it, not the developers?


--=20
Piotr Krukowiecki=20
