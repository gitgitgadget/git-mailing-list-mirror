From: Francesco Pretto <ceztkoml@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2014, #01; Mon, 6)
Date: Tue, 7 Jan 2014 00:45:38 +0100
Message-ID: <CALas-iiKtWQ2FjXusS03PwXHx5R6prw1naKJo4FKz=6qsm-jRg@mail.gmail.com>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com> <CALas-ii8anKWa1qhn29fNxHiLbbrak=5XUSNPw26LBViREiS4w@mail.gmail.com>
 <xmqqzjn8g009.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 00:46:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Jrz-0001xd-VM
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 00:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793AbaAFXqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 18:46:03 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33979 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757784AbaAFXqA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 18:46:00 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so18950160obc.7
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 15:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3fAIxVnsFzDf6RM/EHOLmn2sKDpNcCPliTkHDlpdJRs=;
        b=QrgIJO1cBeFKbgWmnH650G7zLOmt3QDimle9vkVargkJmuR4Wm3WPFJIQ9m1rFb4bP
         YgQGI9KPchIBkbSdDS/B/qcGT+1w3v0rMe1sSZ5EL7gqDxzM4euO0QAtYbL+9oJzjeee
         +IbCDRpnqTJd/HLIs+iAT1mDA2vQps5JVZbT9wTgDreUeDKzwCQzCUQ6Te8AQR0wDHpb
         kjJSyuZ/M4ybMIIfGbEpUQM+OLSJsOJ1eqsMGcV4d+vu5VWEA9FF0BTncMeavcL5FZ1F
         ExUQemftT9v3GtxAjxRa5eGZZ5zmFxTUsSETTslnURn4wGef2QPcpj845qc/EKJ+SGwF
         FB8w==
X-Received: by 10.60.65.101 with SMTP id w5mr74570803oes.0.1389051958987; Mon,
 06 Jan 2014 15:45:58 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Mon, 6 Jan 2014 15:45:38 -0800 (PST)
In-Reply-To: <xmqqzjn8g009.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: X2kPVqyOlk9tYr2AP3yQlYVWZB0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240086>

2014/1/7 Junio C Hamano <gitster@pobox.com>:
> The thing is, it takes a non trivial amount of time to run through a
> single day's integration cycle, and any reroll that comes later in a
> day once the cycle started may be too late for that day.  Otherwise
> I have to discard the the result of earlier merges and tests and
> start over from scratch.
>

Got it, thank you.
