From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Tue, 6 Mar 2012 14:55:21 +0800
Message-ID: <CANYiYbGzy7bCpk4NHUq58s9iJ5bW9Uf+MMpmPEd1XME5wi1rNg@mail.gmail.com>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
	<7v7gyz7pei.fsf@alter.siamese.dyndns.org>
	<CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com>
	<7vobsb67dn.fsf@alter.siamese.dyndns.org>
	<CANYiYbHGAG5ijeL3yW5SKYAfMNwtme5ELPeGNPhNyKBPGTONMg@mail.gmail.com>
	<7v399mw7k3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 07:55:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4oIx-000523-7h
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 07:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab2CFGzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 01:55:22 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39013 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2CFGzV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 01:55:21 -0500
Received: by ghrr11 with SMTP id r11so2077469ghr.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 22:55:21 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.236.184.129 as permitted sender) client-ip=10.236.184.129;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.236.184.129 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.236.184.129])
        by 10.236.184.129 with SMTP id s1mr31538734yhm.21.1331016921248 (num_hops = 1);
        Mon, 05 Mar 2012 22:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=q8x5x/3Xu4eGwe1fPYTDFPwshIrWimGNQnADq4OkbHw=;
        b=vDr97xK3TDLMdqdk8JJ3Ealce+mowOBqBerC4L41QKB2rgl3b/aGe8YaWOFjJJzQy9
         15++u4W6axXQ1UmxUOmF9pvKb7WntUudZgO8Bb8v8V2sVWXsFqhFnY3eG87oB9bSqwG7
         5CkUAYSj4Gce90oF0KA9OisywbGAD609sRmoaMh6tzRQLjCK4BTjJ85UlPR/UmnEOizE
         9gStZUnITTqc+tHwbEWPAYptrlkZRW/hbR8SsY1HHhGQt6Cq+wMg3s2c30PKqFBZkArg
         yACxCSArggb7dX2xvdapkYyyNLqKHr3VZeee2j156jNIzzjDQgScmjcn0/07buhlss7c
         h3pA==
Received: by 10.236.184.129 with SMTP id s1mr24844526yhm.21.1331016921187;
 Mon, 05 Mar 2012 22:55:21 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Mon, 5 Mar 2012 22:55:21 -0800 (PST)
In-Reply-To: <7v399mw7k3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192304>

> In any case, I was not asking anybody to come up with an original
> solution. Rather, I was asking if somebody knew an already widely
> used library-ish implementation we can just reuse. =A0If there is no
> such thing, we may end up designing one ourselves, but we shouldn't
> be doing so if we don't have to.

Still awake? hardwork, admire. ;-)

--=20
Jiang Xin
