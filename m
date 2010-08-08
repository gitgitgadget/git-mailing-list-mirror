From: "Joel C. Salomon" <joelcsalomon@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Sat, 07 Aug 2010 23:46:55 -0400
Message-ID: <4C5E28AF.7010809@gmail.com>
References: <i372v0$3np$1@dough.gmane.org>	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>	<4C599781.2020603@gmail.com>	<4C5B2F2E.4050709@gmail.com>	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com> <AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com> <fGxsOXuy8990l2eOzf2k3cXF066OSIj50KBNkGGWXJhFoVG_B5MV_Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sun Aug 08 05:47:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohwqp-0003af-Bq
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 05:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab0HHDrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Aug 2010 23:47:00 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60626 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab0HHDq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 23:46:59 -0400
Received: by qwh6 with SMTP id 6so6218731qwh.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=j9G79nTCfZ2uDWF4CSHTkTtq7Or6xpuMQpfyVK9pHA0=;
        b=Iy3wv6f/k6uM0E7EMtdEai8VGayfAhDhOlLltqBA28WyUTHQ/oy8gJtC924AizOTlJ
         nWopr70kwhvRhfIzymrK5YbkaG2Cz74p6ExwndTgHnlOKR4hQ5VLDNYJ4aHQD7921Olr
         K3H4QcgNJDl52jckFjxNhjR1MKUjxHG4DRiOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=w2Nc0gRqeebriIzjmYvkHr+24x5Q4eedLjo6JedpNOhhtReh+SElwN3CIqhOF9U92V
         BNm0hF58UKdfqpLHSK0HdXFx+chAAxio7aWIZshwwDZFEXcIM0hC2ARb+ygLtPAJeU6H
         bUBJVXUqy6mBBHKTA9O7IWM8STxo7CZp859uY=
Received: by 10.229.239.3 with SMTP id ku3mr4922332qcb.129.1281239218749;
        Sat, 07 Aug 2010 20:46:58 -0700 (PDT)
Received: from [192.168.5.103] (pool-173-56-160-133.nycmny.east.verizon.net [173.56.160.133])
        by mx.google.com with ESMTPS id e6sm1277701qcr.41.2010.08.07.20.46.56
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 20:46:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Lightning/1.0b1 Thunderbird/3.0.6
In-Reply-To: <fGxsOXuy8990l2eOzf2k3cXF066OSIj50KBNkGGWXJhFoVG_B5MV_Q@cipher.nrlssc.navy.mil>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152881>

On 08/06/2010 12:44 PM, Brandon Casey wrote:
> Joel C. Salomon wrote:
>> Cool, it works!  (The 13:00 should have been 12:00, but there's some
>> DST weirdness at work.)
> 
> Something other than the fact that -0400 should be -0500?

No, that's probably it; I'd overlooked the time-zone specifier.  Thanks.

--Joel
