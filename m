From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] glossary: add "remote", "submodule", "superproject"
Date: Thu, 28 May 2015 11:50:17 -0700
Message-ID: <xmqqlhg8h6za.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kauSsZK3_X+zTwL8TKuZiHNMGvMZfoCemW9-K7RWgrgCA@mail.gmail.com>
	<1432777801-6073-1-git-send-email-sbeller@google.com>
	<xmqqk2vsirbe.fsf@gitster.dls.corp.google.com>
	<CAGZ79kb7M9L-xkMEG1GhAhYVWPR3env2fLiWt4fpbB=e6+jUhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 28 20:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy2st-0000YA-6d
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 20:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbbE1SuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 14:50:22 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35552 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbbE1SuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 14:50:19 -0400
Received: by iesa3 with SMTP id a3so45703437ies.2
        for <git@vger.kernel.org>; Thu, 28 May 2015 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6bLCIQ7UIaFKT/Hc2KA+zuaeyqwtcc2ikOtlRutYElk=;
        b=hD1Yz0eTN4kLryVjDXPcpPfjxjLsTxJu38NS25g45X6W9vwiQk6aKHTT2kav26+FqW
         qwMDQmt0386Il0nwAxqDbpeO9oeED9QuCxnpR5sHtJdyMF8LyLNqp4tSi49i3J8LXthS
         g8+2nVfWpe2fLlk25eX/370KJKDnmo2wwyzmP0fOtg+sapmaanZDyacSl46TkoNjvUhV
         08usaQDbP0zhmD1sMOXr6zWornMfdUrNJx4Nm5+uCdhsmfkLfekRGX91gQ5B3W9ZIuXf
         /Q/CIk8gQI1qPJM73zcqDXlBnhMkZW1+0uFwvbX91hDXS6NQ2Kp/bhyHrKBFHgMBPdtV
         c55g==
X-Received: by 10.107.16.93 with SMTP id y90mr5369317ioi.69.1432839018692;
        Thu, 28 May 2015 11:50:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id b15sm4904249igm.12.2015.05.28.11.50.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 11:50:18 -0700 (PDT)
In-Reply-To: <CAGZ79kb7M9L-xkMEG1GhAhYVWPR3env2fLiWt4fpbB=e6+jUhA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 28 May 2015 10:52:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270178>

Stefan Beller <sbeller@google.com> writes:

> I am not sure if the discussion belongs into the glossary though.

Probably not.  Perhaps in tutorial.
