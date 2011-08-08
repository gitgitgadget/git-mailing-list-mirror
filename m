From: Michael Witten <mfwitten@gmail.com>
Subject: Re: I suggest that git commit support -A option, just like hg does.thanks.
Date: Mon, 8 Aug 2011 14:04:46 +0000
Message-ID: <CAMOZ1BtVy5m0i2co-YEjxGxzMVHpq01vSn0P7UkURHu=AQ=gsA@mail.gmail.com>
References: <20110806150246.GA20650@jpl.local> <35a2b515.12f42.1319f82c79d.Coremail.sinojelly@163.com>
 <4d88745.134ea.1319fe29f01.Coremail.sinojelly@163.com> <1312659297-sup-2956@nixos>
 <buoy5z4ed3w.fsf@dhlpc061.dev.necel.com> <7vfwlc1ox1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miles Bader <miles@gnu.org>, Marc Weber <marco-oweber@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 16:05:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqQSK-00021W-7h
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 16:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab1HHOFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 10:05:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40379 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab1HHOFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 10:05:17 -0400
Received: by yxj19 with SMTP id 19so2494733yxj.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NyIFEaN7yuG8Q5KJhsi4NKco3r1oWmn5fI99+wE8Flc=;
        b=ii+UVmrrD2/bNYKQfgpqlH/6wQNJfgddzD1R4MX3B9t/B4/PydmQhb+BY4kZidXrbI
         NYaGQXc9K7qwm8l8/2wZheAXsCwSQl4wImoHPUn+q/fD5935dnNn2VcECSRFLIVeIF8Z
         nKE/jSdUFFqIByJfNv4s6GKpTf9SHTxA76GU8=
Received: by 10.42.139.131 with SMTP id g3mr5621675icu.346.1312812316132; Mon,
 08 Aug 2011 07:05:16 -0700 (PDT)
Received: by 10.42.170.132 with HTTP; Mon, 8 Aug 2011 07:04:46 -0700 (PDT)
In-Reply-To: <7vfwlc1ox1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178957>

On Mon, Aug 8, 2011 at 04:56, Junio C Hamano <gitster@pobox.com> wrote:
> So far, nobody stepped up to do it, though. I have been taking it as a
> sign that "commit -A" is not one of the commonly desired features but is
> probably closer to your "odd/unusual". It's up to the user/developer
> community to change that ;-)

With regard to anything that can be changed for the better, the vast
majority of people shrug their shoulders, groan, and use what's
already available to them.
