From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 4 Apr 2013 00:46:47 -0600
Message-ID: <CAMP44s3HcLji22JDoSVZG_cLca8LXTbUPuVv8SbAM1yTqn8zcw@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
	<EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
	<CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 08:47:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNdx9-0000QP-8M
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 08:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab3DDGqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 02:46:50 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:64680 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745Ab3DDGqt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 02:46:49 -0400
Received: by mail-lb0-f170.google.com with SMTP id x11so2380782lbi.29
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9g32Robs/V6e8WyybhMOoDeE4E849TJ8hReobSFebv4=;
        b=fLOEfcYejdf6hfgYd62/boRPHKIXLHPnb5md3vcm7raiYVlRM+r1SdgcEKws85fCUg
         vjNoQEfJ5pBrPcLBakUoSuk/MHAoWy/C7pctzHzN0R7nmwhVA/754vzCOVkUjYlayikZ
         xhNzTU49OnAzaZ0vGVf7ZaRm3BWlDd/jsN1GOG7/n0p4fKT1tjp8PcQGyPZtBkUyLuFh
         90odDCXBmFamB4Hxz+viSO53Ki5WhFQGT9iSwAY+ad1+OBZp4F5UTuz1zJbr6eVVRBZd
         ult15RxzRvNqEDC81e7XQhHMqJRT7arkaiGadzR1T5WPu7QE3TBFAM+W5T+wwYaNetm9
         i7nQ==
X-Received: by 10.112.145.197 with SMTP id sw5mr2545749lbb.91.1365058008020;
 Wed, 03 Apr 2013 23:46:48 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Wed, 3 Apr 2013 23:46:47 -0700 (PDT)
In-Reply-To: <CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219990>

On Thu, Apr 4, 2013 at 12:42 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Apr 3, 2013 at 6:25 PM, Max Horn <max@quendi.de> wrote:
>> On 03.04.2013, at 03:31, Felipe Contreras wrote:
>
>>> I only learned about it recently, I've looked at the history and to me
>>> it seems rather chaotic, and a lot of the code was simply copied from
>>> git-remote-hg without comment.
>>
>> gitifyhg was scrapped and completely restarted from scratch at some point. Based largely on your git-remote-hg code. A bit more on its history can be read here:
>>   http://archlinux.me/dusty/2013/01/06/gitifyhg-rewritten/

Please don't CC the gitifyhg mailing list, unlike vger mailing lists
(or any other sane list), it doesn't accept mail from non-subscribers,
which makes communication with outsiders much more difficult, as
demonstrated by this.

---
We're writing to let you know that the group you tried to contact
(gitifyhg) may not exist, or you may not have permission to post
messages to the group. A few more details on why you weren't able to
post:

 * You might have spelled or formatted the group name incorrectly.
 * The owner of the group may have removed this group.
 * You may need to join the group before receiving permission to post.
 * This group may not be open to posting.
---

-- 
Felipe Contreras
