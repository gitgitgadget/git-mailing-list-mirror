From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Thu, 05 Aug 2010 17:37:50 -0400
Message-ID: <4C5B2F2E.4050709@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com> <4C599781.2020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 23:38:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh88a-0004VN-1R
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934235Ab0HEVh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 17:37:57 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58497 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934043Ab0HEVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 17:37:55 -0400
Received: by qwh6 with SMTP id 6so4370975qwh.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=lURC89HYV5msV1mLdjZMSzv5yjQYPQbfN5pJqcRPxho=;
        b=x2lmZyAsOVu8JBmmM6HUBv/kGLAqv04CmpZjuN1g/oe62/BDQfAwuuNsitN+yPEjhv
         k8lMlU60IhbjDS8sFrMn9+mqNmfMeV5qKK+S7j11nsXXFc8fRuk/FgFOCaJjyTHtLVQS
         43xmd9ygGa2FQew0Mi3as8ur+H9Zd5SAmwa9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Lk8Z0j1lWr6Zoy8uzrWkiyW6dsDU9hVy+VXNT5hA9mu0Rp0tEkzj4hB17NvoNgaa96
         bh4RTkYsnBwezvaNmTaNaCoygviFeYBU9c6S+Bk6Y5Eumxn8zvwtuuIZM3deF3dXyrTd
         CzCLEI9whXrHhXzIemvQVXd8omyRTo11pIu+Q=
Received: by 10.224.74.82 with SMTP id t18mr5286351qaj.95.1281044274955;
        Thu, 05 Aug 2010 14:37:54 -0700 (PDT)
Received: from [192.168.5.103] (pool-173-56-160-133.nycmny.east.verizon.net [173.56.160.133])
        by mx.google.com with ESMTPS id r38sm748215qcs.2.2010.08.05.14.37.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 14:37:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Lightning/1.0b1 Thunderbird/3.0.6
In-Reply-To: <4C599781.2020603@gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152723>

On 08/04/2010 12:38 PM, Joel C. Salomon wrote:
> I'll put my Constitution project up on GitHub in a few days.  Just note
> that I *will* rebase and publish.

It's up, at <http://github.com/jcsalomon/constitution>, with one commit.
 (No amendments yet.)

I'm curious to find out if folks with 64-bit time_t get the correct
author and commit times.

--Joel
