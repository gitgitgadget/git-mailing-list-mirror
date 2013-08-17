From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH v2] CEST is +0200 during April
Date: Sat, 17 Aug 2013 02:36:44 -0400
Message-ID: <20130817063644.GF10846@pug.qqx.org>
References: <877gfl1imp.fsf@igel.home>
 <1376711520-4685-1-git-send-email-maandree@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Mattias =?iso-8859-1?Q?Andr=E9e?= <maandree@operamail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 08:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAa8B-0005N2-7z
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 08:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab3HQGgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Aug 2013 02:36:47 -0400
Received: from pug.qqx.org ([50.116.43.67]:50554 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab3HQGgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 02:36:47 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id C544F1E0A4; Sat, 17 Aug 2013 02:36:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1376711520-4685-1-git-send-email-maandree@operamail.com>
User-Agent: Mutt/1.5.21+186 (g51cc38c) (2012-12-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232451>

Mattias, the convention on this list is to send directly to participant=
s=20
in the thread as well as the list.  So I've added Andreas as a=20
recipient.

At 05:52 +0200 17 Aug 2013, Mattias Andr=E9e <maandree@operamail.com> w=
rote:
>-	For example CET (which is 2 hours ahead UTC) is `+0200`.
>+	For example CEST (which is 2 hours ahead UTC) is `+0200`.

While changing that line it would be good to also fix the grammar:

+	For example CEST (which is 2 hours ahead of UTC) is `+0200`.
                                             ^^
