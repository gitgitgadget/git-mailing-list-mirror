From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 01/11] Add new git-related helper to contrib
Date: Mon, 13 May 2013 18:17:09 -0500
Message-ID: <CAMP44s2hmc5rHCC9O-6brtC0VeNgRUZsWurmrr7aSUx_Vr4Kyg@mail.gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
	<1366919983-27521-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0nvWvicFAJEqe0jC+zT3ZvA=Qx3MWXK36zYb2-uYV-aA@mail.gmail.com>
	<7vhaisvqvl.fsf@alter.siamese.dyndns.org>
	<CAMP44s0XnEJWjzU-g=Gq2jJQu-9MJ8S84fAd-7bdomKWEeTCtw@mail.gmail.com>
	<CALkWK0ks0yveTus9w=4MFoCjB6ujUUax4_o48Gy_yevyT6BeyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 01:17:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1zY-00007z-Ac
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab3EMXRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:17:12 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:55364 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab3EMXRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:17:11 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so1394044lab.20
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=5huTiXiIDVoFWc8r1zXckOCae+p6NhDQ7uam2Bct3Og=;
        b=IcMMNpe9MYzNkNbyPyBJUtxTDXexgxDNxD//gA8dN40/1DSpRbwsH08+h/hCqDFuge
         UEWiLYZPxebTR/bBA+oU2Qvf2IRgXi3+OefWBbdlMx+cvCV1yErttl33zWFrzVFL1+Qk
         mlFcXv/iPBfemi4IFMyYv3IpIG5XWkdD94F3Ty8RhB5R2Vz0HoUZlPG9OgC4jx+UEGr0
         KdEBGYTOM79KXTdi5iMlVNxeMKdKz4uQ9QmTVSh6sc+ZEq3FyUaP3iPCj9MoP2bMpnWG
         bFzxZ+97WS+bz90GqdG+bZ+DjaJ3VYQf6uvaGUJ2SghX8MPSlacuCGYwfdF3Xfzgo1eO
         CRMw==
X-Received: by 10.152.3.167 with SMTP id d7mr1734703lad.38.1368487029683; Mon,
 13 May 2013 16:17:09 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 13 May 2013 16:17:09 -0700 (PDT)
In-Reply-To: <CALkWK0ks0yveTus9w=4MFoCjB6ujUUax4_o48Gy_yevyT6BeyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224230>

On Fri, Apr 26, 2013 at 10:01 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> That's fine, I was mostly asking Ramkumar who earlier argued earlier
>> versions of this patch were not understandable.
>
> Sorry, still catching up with list emails.  At a glance, part 1 looks
> much better.  Will read through more carefully soon.

Gentle reminder.

-- 
Felipe Contreras
