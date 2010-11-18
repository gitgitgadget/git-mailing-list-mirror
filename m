From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git roadmap (How read What's cooking in git.git)
Date: Thu, 18 Nov 2010 21:41:10 +0700
Message-ID: <AANLkTi=ggFa4mwd=vkxJYq-JgCT=Tkmkv-0RQ_cqeYWm@mail.gmail.com>
References: <AANLkTimtUz3L0F_iOpH7YuYpyoutPqtevPj-Tjo6MRcs@mail.gmail.com>
 <AANLkTim4FOixgxUjv24o9gTNqK3DWafmpNtDVMA+PS9d@mail.gmail.com> <AANLkTikDyxUWBnCzxRNA9MzBmr0LrqDb1ggNjOTc=7DR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sebastien Douche <sdouche@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 15:42:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ5gh-0006Ea-Ay
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 15:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758545Ab0KROmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 09:42:05 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40362 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758388Ab0KROmD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 09:42:03 -0500
Received: by wyb28 with SMTP id 28so3304318wyb.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 06:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=lUedW1h5RgMSCkcTF1DuP/8ZvxV+IDDDWeEd7bEBWLc=;
        b=Lojz5/vx8lVPjjMRS/eJEcktuw2V3QX5Z29fVnqWnNBZoemJwWmxAun13ps3fLyVJM
         uhD+87kDVETAya6i2+1BFeimhvbGrnWBymMRIhL9k6hBWehlMtSm9y/iSUFtmRGR9jxr
         WC9mbFGDqV2SxZYTVCsTNECS9cFqAkcVo8BQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cTqrgsmdwWLvR9K0QwbD05VXw2fm+J9QgKTKWl7jvL5uq3y8w74q1TTp2/8C5IWX2D
         0c1GzmYo8S2jSLHLUTNh2F23j56xRfxxAqB76h7GGu8Phd72U5iep9Ofg5/jY3Vb9/oO
         GcSVTH67AFqWsovI8WQDP/V9Aoij1HJhAFo8w=
Received: by 10.216.163.148 with SMTP id a20mr3117589wel.41.1290091309935;
 Thu, 18 Nov 2010 06:41:49 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Thu, 18 Nov 2010 06:41:10 -0800 (PST)
In-Reply-To: <AANLkTikDyxUWBnCzxRNA9MzBmr0LrqDb1ggNjOTc=7DR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161673>

On Thu, Nov 18, 2010 at 8:55 AM, Sebastien Douche <sdouche@gmail.com> wrote:
>> You can get something like a roadmap just by following what people are
>> working on, and asking them what they want to do next.
>
> Understood. I will make it.

Any chance you can revive the "Git Chronicles" [1]?

Junio is too busy to update it (see his reply in [1]). I'm sure it
would be really appreciated.

[1] http://mid.gmane.org/201007081057.51946.jnareb@gmail.com
-- 
Duy
