From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Tue, 13 May 2014 17:52:09 -0500
Message-ID: <5372a2192893b_36d4a0330448@nysa.notmuch>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
 <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
 <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
 <536d4e7ba8ea_585ea5308a9@nysa.notmuch>
 <CACPiFCKoegOj+dxAw87UgrrwrvPSDoFzyxZV1bEPNseiK2M7vw@mail.gmail.com>
 <xmqqsiodo7o6.fsf@gitster.dls.corp.google.com>
 <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:03:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLj7-0002Y3-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 01:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbaEMXDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 19:03:09 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38659 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaEMXDH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 19:03:07 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so1228057obc.21
        for <git@vger.kernel.org>; Tue, 13 May 2014 16:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=j0yXkIMmEuxaRn1o+Cz3n7mUflbQo8YpaCQ73g5tBH8=;
        b=RfMRPlafImjYEG91Ib+BgJ+hlQ6d0XyWO5xN8LXikpc06R90O/Rn6sFKyKsj+04+2B
         0sJxEG1f0D+tiqWeQaMf1VYJVZVA7zQgNZ6Lvi2LYfqBQ2f0bt0iYQ3m+/iE942ZVC2L
         xzwDl1fQOCl8dCFzNoEU21Rwur0YjdY9ltHu4mkNlylSNyhzcCpnhsYLhRe21ayo9D+x
         x4wSfu8gX9qIMNkvYEuLL8y/eRejdpyPpcScVDPfyV1Ru58LXUgRw/5EiDgUtvkZ3OJO
         Oh7KuAfo6JevdoBKtBLCvukLdTBDNW8DhVExvY35SNfNs+a7OytbLwi6TeeKJlONfqOa
         jAug==
X-Received: by 10.182.165.73 with SMTP id yw9mr45376290obb.39.1400022186185;
        Tue, 13 May 2014 16:03:06 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id r3sm24720961obi.23.2014.05.13.16.03.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 May 2014 16:03:05 -0700 (PDT)
In-Reply-To: <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248884>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio, do you honestly think I am a troll?
> 
> You certainly are acting like one, aren't you?

I'm deeply offended by the fact that would think that I'm purposely
intent on provoking people, or disrupting more important discussions.

I understand how my style of communication can upset people, mainly
because people are not used to frankness. But I thought you of all
people would see how much effort I've put into so many areas of Git, and
therefore that my primary objective is to improve Git, not offend
people. That you would understand that me offending people is a
side-effect of me trying to improve Git, not that I improve Git just so
I can offend people.

I understand why you would choose not to reply to some mails that might
be too flammable, or unimportant, or difficult. But in this case, the
culmination of countless hours of work, what I had in mind since the
beginning; that the tools graduate into the core, was finally there, and
you took it away. And then you didn't give an explanation, and then you
ignored me.

I thought you would understand that most of the code that arrived to the
mailing list had different versions behind, experiments, discussion in
different channels, tests, and that was the reason why most of the code
I submitted to remote-hg and remote-bzr simply worked, and it was
simple. And why when other people did the same, the results were not so
satisfactory.

But no, apparently you didn't value my work at all. Maybe you thought
each line I sent took me the time it takes to write a tweet, maybe you
thought because it's in Python even kids in primary school could write
it.

In fact it's worth so little to you that it's not even worth the time to
respond *one* question, not even in consideration of all these years of
effort.

And then you have the nerve to call me a troll on top of that?

I'm done with you. Consider the bridge burned.

Good bye.

-- 
Felipe Contreras
