From: Christian Couder <christian.couder@gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 11
Date: Wed, 13 Jan 2016 15:02:24 +0100
Message-ID: <CAP8UFD1QighgB=Q3ETr_j8EySEQ+P503QLEF_fTXy5QUTmpAwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <stefanbeller@gmail.com>, lwn@lwn.net,
	Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 15:02:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJM0c-0003Tk-JJ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 15:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761026AbcAMOC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 09:02:27 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35329 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759679AbcAMOCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 09:02:25 -0500
Received: by mail-lb0-f177.google.com with SMTP id bc4so290265893lbc.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=8fnZzFf2Hy97/YIpTFd0Vcumk3ZeHWSbBmUj32UPmQk=;
        b=JkGrlFGGYsy4EvO3svXF2ehJHBeoOa/C91IifMcQ3AywJDelh/HCxfwHM/hIYy16g0
         8JS1PFgvvliInWDKkzrrwL48f5oqu+RplXR4qfsa8swr6JxC4HX1m4H88U2tjf1MH0JV
         2viJKVcTmtoWaRV2dyPdl8FkUumqUPXLkOy3Y9eFpERR/pobNYHnTJLjt3p/Jrem3qyf
         ZwA0KcvPHPZzOG/sRH7h5lFJ/PgXxqOp6EzsNb9xsypl2soggJD7LPCzAfUBXaIH4JlZ
         ta9QPzQxgBic+BXMuDb6G7BCXxHnykz+Ig+2gH8x5KfnUdOAJXN1pZaHCxBV69/xR2+k
         tCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=8fnZzFf2Hy97/YIpTFd0Vcumk3ZeHWSbBmUj32UPmQk=;
        b=dmdZ1SY6OYr6xxcT0gMKhc1ZWQ6GHje7w2Sp0VlVcxopN1GxRNmqFzDi9mAtYWJfJo
         Jubew9x66L4cUG3JlloMoqL+hqYq1xVxyAtZXCX6OqQR/9en9tTL620fSWpWUMcoCL59
         21HGQgen0f04VKMcxiy0AQSauZKPi0MfJuHpyQBr5VLVUi1NuXmaIooMHbJFhWLHzMLL
         0SlICWZ1epxaALvm7Fq4e06k1iLB7ZOKLokBbxkcxCCDQ+XyYu1fZtQdzu86aZULQnRP
         Pofru2uC3xoCoXKLQ2omUHBCtRIrRlYtwjrcpEnkjxlRqB+AoKvDYmS/OKaA0/SDI193
         QsMw==
X-Gm-Message-State: ALoCoQkMl0WoOzu+7svqQquJfcwwu4dr5X4Ykjj/8w67CdUTxLsQqXbJGDtVIQkbVxxQc5eLUp5/2hTruIP0IUkTj53ef7uOGQ==
X-Received: by 10.112.64.5 with SMTP id k5mr32763456lbs.133.1452693744444;
 Wed, 13 Jan 2016 06:02:24 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Wed, 13 Jan 2016 06:02:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283921>

Hi everyone,

I'm happy announce that the 11th edition of Git Rev News is now published:

https://git.github.io/rev_news/2016/01/13/edition-11/

No "Developper Spotlight" in this edition sorry! We will try to do
better next time!

Enjoy,
Christian, Thomas and Nicola.
