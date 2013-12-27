From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: german translation bug
Date: Fri, 27 Dec 2013 10:20:11 +0800
Message-ID: <CANYiYbF2xqhFKJM9gB+jGim=4pjxdPF6_36JjavSin+5XSB3SQ@mail.gmail.com>
References: <1573480.3a5WD62Cc4@i5>
	<CAN0XMOJf=H__eFmbcBs-S50ASun94ASL9FiL1zM6eeTheYpxTg@mail.gmail.com>
	<1513689.dimJgKglhA@i5>
	<CAN0XMOLAGQbxLXR16+37WFeCUWnNze8CwoV4+-9-FU0Mz5LZkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wolfgang Rohdewald <wolfgang@rohdewald.de>,
	git <git@vger.kernel.org>,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 27 03:20:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwN2C-00066b-UB
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 03:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab3L0CUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 21:20:13 -0500
Received: from mail-wg0-f54.google.com ([74.125.82.54]:43733 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab3L0CUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 21:20:12 -0500
Received: by mail-wg0-f54.google.com with SMTP id n12so7922735wgh.9
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 18:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pY3J4CpS25ArRs3iLhgNQI5gkVwGsCb5quubW2aWGfY=;
        b=FiF0Y10IPeGi3X9NqoZ/Rw7SZdXu7g8jmJqCAUirF2HVAfTm6KZ75FE2Iy1i3HUJad
         e9AF1guTJDH7ruUTMAtTMQo3L1YLG+SMG2i7W6/kBQt89GdMF7nKmC6DgpJ0sNPP5d4+
         83ZmR1m4EWveo/rJ6MIrBYIEBM9CL3EOPh1W2svF/7uz9QvOdbSVK/sRfeq4QUqNZGaG
         2ezaxRWt4gagZ3aaf8I6D6HCuDa/30qSDvPPy2xNLFR4xJpEnR1xx5mrBrCx+mj335ww
         JfRJz7CU4mHozLIdxXQw6CerKL4HfLbMr2RokwvZqB4XMU6+Uni3UtTjUtjd/ZWfv9Fb
         LG0A==
X-Received: by 10.180.79.106 with SMTP id i10mr20832645wix.23.1388110811384;
 Thu, 26 Dec 2013 18:20:11 -0800 (PST)
Received: by 10.216.213.207 with HTTP; Thu, 26 Dec 2013 18:20:11 -0800 (PST)
In-Reply-To: <CAN0XMOLAGQbxLXR16+37WFeCUWnNze8CwoV4+-9-FU0Mz5LZkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239719>

2013/12/27 Ralf Thielow <ralf.thielow@gmail.com>:
> On Wed, Dec 25, 2013 at 10:53 PM, Wolfgang Rohdewald
> <wolfgang@rohdewald.de> wrote:
>> Am Mittwoch, 25. Dezember 2013, 21:59:10 schrieb Ralf Thielow:
>>> What version of Git do you use? What distro in what version do you use?
>>
>> freshly installed kubuntu 13.10. The package language-pack-de mentioned
>> at the end of this mail is installed.
>>
>> I suppose I should open a KDE bug report?
>>
>
> The Ubuntu translators have already updated the
> German Git translation for 13.10. So the issue should be
> fixed in the next language pack update [1].
>
> AFAIK Ubuntu ships the translations aside software packages
> that they're able to update l10n without updating the software
> itself.
> They also maintain the translations for themselves. Issues that's
> been reported to them also getting fixed by them. However, those
> fixes do not necessarily find their way to upstream Git translations.
> The benefit of reporting issues to Git ML is that they can be fixed
> in both upstream Git and Ubuntu. I'll try to keep an eye to launchpad
> and fix bugs in German translation reported on the ML on both places
> in the future.
>
> Thanks for reporting the issue.
>
> [1]
> https://translations.launchpad.net/ubuntu/saucy/+source/git/+pots/git/de/+translate?batch=10&show=all&search=nothing+to+commit%2C+working+directory+clean
>

I reported the same issue recently, and you can see reply from
Canonical in this thread:

* http://thread.gmane.org/gmane.comp.version-control.git/239130

-- 
Jiang Xin
