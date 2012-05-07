From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH 2/5] l10n: de.po: translate "track" as "folgen"
Date: Mon, 7 May 2012 13:08:17 +0200
Message-ID: <CAN0XMOJgp-i=nd_7ygX=WuaegK6zMRypxRYH8nfGw6FLPAA1Fg@mail.gmail.com>
References: <1336160906-20708-1-git-send-email-ralf.thielow@googlemail.com>
	<1336160906-20708-3-git-send-email-ralf.thielow@googlemail.com>
	<1543115.9YNtu9coLS@cs-pc>
	<87obq08fq5.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>, jk@jk.gs,
	git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 07 13:08:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRLni-00011J-Ow
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 13:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab2EGLIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 07:08:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55766 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab2EGLIR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 07:08:17 -0400
Received: by yenm10 with SMTP id m10so3511515yen.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8GpLEwJCw6H13VDjpy/N/+s2nU1oBCiYBvS//06MbQ4=;
        b=AaK8edP4zMrvo0kaJ/iWsOVAOsGqkOPqJSOcT9EXrYYhmt4JfJ82vmcpS2ApylV4Ze
         RGZG88ITpL5ocniJIyxajzIgbNA7KEpP23QW4C0ILUx0QI29fmpUpwnfG1OAX2Lg6H9X
         5wHr42GV8GGSef3UKAfiAxpiXvMyqQ1qjUfqI+9zSoJmnr1NG/7ue8Uquo8/W08q1XxY
         RkvBLg8eS6M5h1UnXQ82DhDuF7sF6Ggo4Jw+A0dsqSQryoWRJpE8pOyPWnYVUd14IWxg
         89guaQkecMre8iV+1zV7ntJN2WsxlVCXKi0Se1NbroQvzsJuYzwoG5rF0ggMRLyi0JYK
         fZiw==
Received: by 10.236.75.232 with SMTP id z68mr19836663yhd.6.1336388897244; Mon,
 07 May 2012 04:08:17 -0700 (PDT)
Received: by 10.146.218.6 with HTTP; Mon, 7 May 2012 04:08:17 -0700 (PDT)
In-Reply-To: <87obq08fq5.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197259>

On Mon, May 7, 2012 at 12:09 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>
> Good point. =C2=A0In addition, both "folgen" and "verfolgen" have the=
 problem
> that several derived words sound funny; e.g. "verfolgt" and "folgend"=
=2E
>
> How about "beobachten" (for the English readers, roughly "observe") o=
r
> "beachten" ("pay attention to") for this meaning of tracking? =C2=A0T=
he
> latter even forms a nice group with "unbeachtet" and "ignoriert".
>
> You could use "folgen" in the remote-tracking sense instead?
>

Good suggestions.

I personally prefer "beobachten" for tracked files/contents and, as you
said, "folgen" in the remote-tracking sense. But I wouldn't use
"ignoriert" because it has another meaning in git.

Ralf
