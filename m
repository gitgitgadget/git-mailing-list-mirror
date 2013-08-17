From: Mattias =?UTF-8?B?QW5kcsOpZQ==?= <maandree@member.fsf.org>
Subject: Re: [PATCH v2] CEST is +0200 during April
Date: Sat, 17 Aug 2013 08:40:57 +0200
Message-ID: <20130817084057.36e08be1.maandree@kth.se>
References: <877gfl1imp.fsf@igel.home>
	<1376711520-4685-1-git-send-email-maandree@operamail.com>
	<20130817063644.GF10846@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 08:41:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAaCJ-0008Oo-CB
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 08:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab3HQGlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Aug 2013 02:41:10 -0400
Received: from smtp-3.sys.kth.se ([130.237.48.192]:39916 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab3HQGlJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Aug 2013 02:41:09 -0400
Received: from mailscan-2.sys.kth.se (mailscan-2.sys.kth.se [130.237.48.169])
	by smtp-3.sys.kth.se (Postfix) with ESMTP id 1526E2711;
	Sat, 17 Aug 2013 08:41:08 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-3.sys.kth.se ([130.237.48.192])
	by mailscan-2.sys.kth.se (mailscan-2.sys.kth.se [130.237.48.169]) (amavisd-new, port 10024)
	with LMTP id oCdctueP0j7v; Sat, 17 Aug 2013 08:41:05 +0200 (CEST)
X-KTH-Auth: maandree [193.150.208.92]
X-KTH-mail-from: maandree@member.fsf.org
Received: from localhost.localdomain (c193-150-208-92.bredband.comhem.se [193.150.208.92])
	by smtp-3.sys.kth.se (Postfix) with ESMTPSA id CFA6226A5;
	Sat, 17 Aug 2013 08:40:59 +0200 (CEST)
In-Reply-To: <20130817063644.GF10846@pug.qqx.org>
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.20; x86_64-unknown-linux-gnu)
X-Awesomeness: 120 %
User-Agent: Claws Mail
X-Operating-System: GNU/Linux
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232452>

Sorry I forgot to add him when I used `git send-email`.

On Sat, 17 Aug 2013 02:36:44 -0400
Aaron Schrab <aaron@schrab.com> wrote:

> Mattias, the convention on this list is to send directly
> to participants in the thread as well as the list.  So
> I've added Andreas as a recipient.
>=20
> At 05:52 +0200 17 Aug 2013, Mattias Andr=C3=A9e
> <maandree@operamail.com> wrote:
> >-	For example CET (which is 2 hours ahead UTC) is
> >`+0200`.
> >+	For example CEST (which is 2 hours ahead UTC)
> >is `+0200`.
>=20
> While changing that line it would be good to also fix the
> grammar:
>=20
> +	For example CEST (which is 2 hours ahead of UTC)
> is `+0200`. ^^
