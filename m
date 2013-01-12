From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH] t/t960[123]: remove leftover scripts
Date: Sat, 12 Jan 2013 00:06:30 -0600
Message-ID: <CAEUsAPayhLXrMR9K4KTkV+yCVjV+TzTi48ytj1NfcAgOEhCN+g@mail.gmail.com>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
	<7v62339du4.fsf@alter.siamese.dyndns.org>
	<7v1udr9d0g.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 07:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtuF2-00010Q-4b
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 07:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab3ALGGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 01:06:32 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:60565 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab3ALGGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 01:06:31 -0500
Received: by mail-la0-f50.google.com with SMTP id fs13so2436099lab.37
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 22:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=rK0BK24mK4CVYNPpS/Xvz7MjB/PYyLNvnn7zGljUFc4=;
        b=y/tBdoFFCCG0WuNfOrw6op2fnBpWt+RiiX5YfD37HyvAFmep5n2TaL95Sibz9Y1c5Q
         SoOAKuciclITmWBFEI1hjFZEDiExlTHL6Oa5fVRbiKJSpAmoCnC8lPiXOWR/YGxMXVEU
         pNGv1eDB+5nrVz2UrisZoFMj1rz2/zH6or+/EOBKz4gwWdIphcK2rE8pbK99+thSK04Z
         pEp2y2L9hl/KPZzvkxruX2Zd0cBQ+gCTmeROpthLU65aRCgOrQcAwhXgZEAgoOOe6brT
         d9Yp1nekey6pl1gHZ9h6QftkeglHjzc2cut7FvjYKd0l2FKxN6J97NjxPQUHoezcLCEx
         mspA==
Received: by 10.112.46.199 with SMTP id x7mr31909866lbm.109.1357970790252;
 Fri, 11 Jan 2013 22:06:30 -0800 (PST)
Received: by 10.114.94.228 with HTTP; Fri, 11 Jan 2013 22:06:30 -0800 (PST)
In-Reply-To: <7v1udr9d0g.fsf_-_@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 0CX969Ab-h8xwv5SoecfJ-Pwpyk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213267>

On Fri, Jan 11, 2013 at 11:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>    By the way, Chris, we'll need your Sign-off on the three paches
>    (t/lib-cvs.sh fix to allow cvsps v3, t9600 fix and t9604 fix).

Sure.  I was just maintaining them for myself but thought I'd share
when I saw the follow-up patch.  Didn't think to amend them.

Chris
