From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 6 May 2012 23:30:13 +0200
Message-ID: <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr> <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 23:30:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR92R-0000qJ-58
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 23:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab2EFVah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 17:30:37 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54342 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab2EFVag (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 17:30:36 -0400
Received: by eekc41 with SMTP id c41so1249740eek.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mT2LLJaVpITF2tJREfxgb0nS+GN504oIPovgZ0Jx/tc=;
        b=Ys+YD0hwURJHeoNZhKpVTjX6I15FmfzDbulDHwS0TycyIpsp5qqaUE3WQ+hmsPwovB
         TWA+NVRRd5JIQPdWNx6jiLxa7GytKGtkae842gkT+Tbh9Jd9jvghEMHAzTdd6J4cuUdL
         teqJm2texnn5MuSgbrAH7zsB3kQGmGfrl1m+dX10XYviefzl1u0O5L7I6QuqUoGShpad
         /Rz6oj/nR3ywUx/ZI5gtuxdRkZVPvs6jjGxzJENqvJgEqUQ9tprbo4eU5d7/zfbKp2Yn
         X9NnZnWiFr8X1dNAt3qOQTvi/yY8oJG9oJOkv27xmO/yJUjEAIPN5jagMjkb68zyX7tX
         74fA==
Received: by 10.213.157.2 with SMTP id z2mr2292942ebw.149.1336339833901; Sun,
 06 May 2012 14:30:33 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Sun, 6 May 2012 14:30:13 -0700 (PDT)
In-Reply-To: <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197217>

On Sun, May 6, 2012 at 11:16 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> I don't know, precommit is not an English word, and it was discussed
> before, but not many people vouched for it.

FWIW in the Icelandic translation I translated "index/stage" to the
equivalent of "the commit area".
