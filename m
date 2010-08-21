From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Proposal for new Git Wiki admin
Date: Sat, 21 Aug 2010 15:26:08 +0300
Message-ID: <AANLkTinyMb6mw9jDhhDzs2HNjKWL5Q=Ofi6SU9BqdY35@mail.gmail.com>
References: <20100810162602.GG3921@kytes>
	<m3y6ce2kdz.fsf@localhost.localdomain>
	<20100811050056.GA3715@kytes>
	<4C62494A.2030805@drmicha.warpmail.net>
	<AANLkTimuHzC_brw2bBDTvc=-Cj+70AMFEj7nzspW5mGq@mail.gmail.com>
	<20100811134640.GA10888@kytes>
	<20100811142359.GB10888@kytes>
	<AANLkTi=cFf+DPzMw=BV6979ATMP4Z1845sFVmLSJy33=@mail.gmail.com>
	<20100820122813.GA9448@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Warthog Hawley <warthog9@kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 14:26:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omn9W-0006Kn-CF
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 14:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab0HUM0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 08:26:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54222 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0HUM0J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 08:26:09 -0400
Received: by iwn5 with SMTP id 5so1796660iwn.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 05:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=dzHbU6rhB2oDBRqypTl1RTu65tsinn7LQld5OqLBftY=;
        b=F75uNVTLaZZD+t9ttx8iS4kyiZ8jZIbXJzIty6DBwgCToheiY2/LNVxCmbX8phcueG
         aNZqhliE5o4EZa/hpeMHk84dWuASSog3rMWc9/1Mf0g3BPXUx+JuhIoBhxpWAf4Kkwif
         j1h5Y92VCnSSVfHClIvQtx3qto8+jQK9lUEKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GlBUlxqefICua1pOGye4/Bnan5w5yk9sLY3i/VWURIfcYN+4HAvtDKfri/cM5v1hb+
         PHzMwn78tbLGUIlNemHQ9BA4ObHssXj7W0I35cYfMvKWkLQwxZJcf5l22IuE6qNsyn82
         x//lWvKOriTjjzBNk0tv1vQ/yBuIuwnBppx2w=
Received: by 10.231.11.72 with SMTP id s8mr3082408ibs.110.1282393568241; Sat,
 21 Aug 2010 05:26:08 -0700 (PDT)
Received: by 10.231.161.136 with HTTP; Sat, 21 Aug 2010 05:26:08 -0700 (PDT)
In-Reply-To: <20100820122813.GA9448@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154139>

On Fri, Aug 20, 2010 at 3:28 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras writes:
>> On Wed, Aug 11, 2010 at 5:24 PM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>> > Could you make 'Artagnon' and 'JakubNarebski' administrators on
>> > git.wiki.kernel.org?
>>
>> Why hasn't this been done?
>>
>> Also, Johannes can give admin rights too.
>
> No, Johannes can't. He's not a bureaucrat [1].

Right, well, I think we need a bureaucrat that's also part of the git community.

And BTW, here's a true spammy user: Demver5. It would be a lot easier
to report these if patrolling was enabled.

-- 
Felipe Contreras
