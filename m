From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Mon, 20 Aug 2012 08:21:42 +0200
Message-ID: <1613947.h8N3CdhuYo@flomedio>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vzk5srm9w.fsf@alter.siamese.dyndns.org> <7v1uj3qthh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:22:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3LN9-0001ps-GJ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 08:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502Ab2HTGVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 02:21:49 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:53251 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380Ab2HTGVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 02:21:48 -0400
Received: by wgbfm10 with SMTP id fm10so3080278wgb.1
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 23:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=oBRtiFlU0WyupxH+EmsaNwwMfEbcVEEdNh3RjBqEz18=;
        b=X0pE4SFEXgArXA1hhDeIczidavgIMFMNrFvImjYHoz3tsxW+ed0eMAJeuQWKgJNcw7
         1v4qN8z5eFQbW0x9hbOFl/4Iy5DB5SMqMNxJN28EnuF53AfpXLUmnBOYXomZaN7Zutvf
         qMv4uokdn/8UXwwTwCCK4N4SrtfaOznduHnTVbk+gnuyyRlnd4QV0WLs08Rs0fzURdEg
         PtxAsLl2NtxyEYu2b6pgQ87KoqtjX5Wao+Nday6dB2yCmEdWsDS9fxQjrh45npozGr2Z
         Xnw8NMbSu/UKLXez9xXbeGlExMSJdNmWh9wG3fwnz7X5T5g5vGekQ8NQ0Ppn7eWxWx0P
         lgiw==
Received: by 10.180.78.2 with SMTP id x2mr26188987wiw.10.1345443707010;
        Sun, 19 Aug 2012 23:21:47 -0700 (PDT)
Received: from flomedio.localnet (089144206224.atnat0015.highway.a1.net. [89.144.206.224])
        by mx.google.com with ESMTPS id l5sm39169579wix.5.2012.08.19.23.21.44
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 23:21:46 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7v1uj3qthh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203758>

On Saturday 18 August 2012 23:35:38 Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> [..]
> Just to show how, here is what I did just now.
> [..] 
> Thanks.

Thanks for you guidance!
I'll base a new version on your fixups.

Florian
