From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] completion: make compatible with zsh
Date: Sat, 14 Aug 2010 03:23:32 +0000
Message-ID: <AANLkTimknF-m4_TYt+-vBBW0e3A-DY1nY93k7mPybdaD@mail.gmail.com>
References: <1280890654-18486-1-git-send-email-lodatom@gmail.com>
	<AANLkTikrE1Fy2Trz6b4MSJk6KzMvH9gDoYWwOEgYkFRJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 05:23:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok7LO-0000Wo-6M
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 05:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975Ab0HNDXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 23:23:33 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37726 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab0HNDXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 23:23:32 -0400
Received: by ywh1 with SMTP id 1so1209907ywh.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 20:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SL6WUanumj8PpswbR0pz1dVl4GEJoEsKnLTo2bTqdTQ=;
        b=HgRyyDWqzTw5EAanKIycOQdKlEP8Yq0+sdZgOmhzZR1kDyTnx1Uqr1PZJOdHrnfeTS
         HchKWBdfgah8dWWryID8O6qVtNdp612ON2Th9eVztDtQ1hbA4OHH6NC5Ir3w9jxIS8o4
         8iXls7O7T/wJzklOzTfZFqXxhEVFRerp0Bkds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B2prmtM1kS2GScubJmA04cIs6gWpGrhLZ5MFb32zq6WXbC/fNUvYpuMtOi3uNGDeh9
         6X68JjdpPZgDlnzRkdTKQ8Nv0x/lueiorn2YDqdRdKHcVusC1rM/t/NJK42QEVSpaA1C
         qDr68PkuohWMIu4aWLMXyFldciUq020RBeUvE=
Received: by 10.231.146.141 with SMTP id h13mr2619005ibv.1.1281756212093; Fri,
 13 Aug 2010 20:23:32 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 20:23:32 -0700 (PDT)
In-Reply-To: <AANLkTikrE1Fy2Trz6b4MSJk6KzMvH9gDoYWwOEgYkFRJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153544>

On Sat, Aug 14, 2010 at 03:17, Mark Lodato <lodatom@gmail.com> wrote:
> On Tue, Aug 3, 2010 at 10:57 PM, Mark Lodato <lodatom@gmail.com> wrot=
e:
>> Modify git-completion.bash to work with both bash and zsh. =C2=A0Mos=
t code
>> works fine, but a few things need tweaking. =C2=A0Where possible, co=
de is
>> written in such a way that both shells interpret fine, but some area=
s
>> need special-casing.
>
> Is there any interest in this patch, or anything I could do that woul=
d
> make it more likely to be accepted? =C2=A0Perhaps at least some of th=
ese
> changes could be implemented.

What's the Message-ID for that patch? I can't find it in my mailbox or
in a public archive (via Google).
