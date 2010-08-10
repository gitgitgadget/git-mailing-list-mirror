From: John Tapsell <johnflux@gmail.com>
Subject: Re: wiki "abuse"
Date: Tue, 10 Aug 2010 19:46:29 +0900
Message-ID: <AANLkTikbOjy-8ViJnUJ1cg4Zm-XQyhP4e_hW8u1xxbDU@mail.gmail.com>
References: <AANLkTimyyh+MyS6zpJp1_RfCOoj6yr4LHXXM_7ZiWgzf@mail.gmail.com>
	<AANLkTi=wxre8pEDPQBeA4FvGcFHKS-kBdCqDv11o=x1c@mail.gmail.com>
	<AANLkTi=GmOokrPoevARoxe16ZLpHKzaBy0tBfycJM5J2@mail.gmail.com>
	<alpine.DEB.1.00.1008091820320.8314@intel-tinevez-2-302>
	<AANLkTinEEpvJv6z1WNgoMujoZyhU8zON597mY+Bp7nV8@mail.gmail.com>
	<AANLkTin5q5WZFUXkZQ3V5Z1fQjYU2QOi5mFpn-Rb7m04@mail.gmail.com>
	<4C606E1B.6020800@lsrfire.ath.cx>
	<AANLkTikNDdi1gDaoWdHsiUPLW2CtZMP0J2c94DpLA=AV@mail.gmail.com>
	<AANLkTi=dhmxBpTehFFMZGnbTVccbMJLmzKy2V0uj9R6r@mail.gmail.com>
	<AANLkTi=dGWaRa3HR4nb6Ka1+0CovrBMnyZts5d8RZW1c@mail.gmail.com>
	<AANLkTimr8vDeyRLLjM+J2Z1zmdiXjwZEw2JAXeXvzNt6@mail.gmail.com>
	<alpine.DEB.1.00.1008100051440.2983@bonsai2>
	<4C608CB2.8000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Git List <git@vger.kernel.org>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 10 12:46:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OimLv-00011w-Ib
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 12:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab0HJKqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 06:46:32 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41304 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab0HJKqa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 06:46:30 -0400
Received: by qyk7 with SMTP id 7so3077765qyk.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Uhgnq2vlAoTx8IK5jUi2H6mw49iDMs6q+vsqHWsHIkk=;
        b=mu+66/OHrbJf6BPDFB/p3cHUwZUQlv1pm64G3Be6dHpC9hF7MrlRKB7E9FB0DjoHu3
         BhznGnDU3eIr873jHZQq6D8neXvGmPN3PSojhYAMndY7LMCGdtPcxeVOuTMvC2m370ua
         rYVpzvAa3g/VkwBgRD8i/hBjI67AnFEKTZyfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iOYi7f8DtqwCakfKE66gVOJezdfC8aY8t6Lj0JA9KJMsk6YnG7JUntlWjZDDEkNewc
         tNLFmjh3Bz8mhvEaBR18qNtGhf5S5XpaEq1kKOWF5eN678HWNe5O9PzQrGFMS1mIHHbw
         Us/5o8+s1K8vOQEwND4n72562azVF0R94Y4jE=
Received: by 10.224.69.14 with SMTP id x14mr9369452qai.212.1281437190041; Tue, 
	10 Aug 2010 03:46:30 -0700 (PDT)
Received: by 10.220.97.145 with HTTP; Tue, 10 Aug 2010 03:46:29 -0700 (PDT)
In-Reply-To: <4C608CB2.8000602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153089>

On 10 August 2010 08:18, A Large Angry SCM <gitzilla@gmail.com> wrote:
> Everyone else: Most of this thread was/is well intentioned but there is a
> significant problem with spam on high profile wiki sites (like ours) and the
> information readily available (from what I've read on this thread) to the
> _volunteer_ wiki admin slash spam fighter fit the pattern of a spammer. If
> you believe that Johannes is not doing an acceptable job policing the wiki
> _AND_ you are willing and able to do the job then speak up with that
> information.

The problem though is that Johannes does not see anything wrong with
his actions.  It's not like it was just a mistake, but he is pretty
much saying that he will repeat his behavior of banning people for
asking polite questions.

I can understand being reluctant to criticize him for fear that if he
leaves someone else will have to take up the job (or worse, noone
does).  But I do think it's important to not let such issues slide out
of such worries.  It should be important for you guys to attract new
blood to the project, and things like this does put a sour taste in
mouth of new developers.

Amir has shown nothing but ultra politeness throughout this thread,
and has even apologized to Johannes (though I do not see why), and in
return he has been attacked.

John
