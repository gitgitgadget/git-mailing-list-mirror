From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 09:09:21 -0500
Message-ID: <CAMP44s0baW0muNzZb1yjDXiS=y3_R5LhzWcqEsPzNZizETwACQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<CAMP44s012ccmaArrTbfy_xNrqbnOjVGTnY+po9cE8JGh_U72Gg@mail.gmail.com>
	<CANgJU+W1BLOB_TuMa_zRHtCW-8Ge8nu_kK=5qu2xDY=Km_kk4A@mail.gmail.com>
	<CAMP44s3zuDPTApPvnaC0bzqmAUkRRwePZDRL4syB=tM3d6eiBA@mail.gmail.com>
	<m3d2rz5svw.fsf@barry_fishman.acm.org>
	<CAMP44s0M5tsN+zYoa_HC+8SLqyvDUBi_wuiOGyQWo0XWbWXC-A@mail.gmail.com>
	<m3ip1rnygk.fsf@barry_fishman.acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Barry Fishman <barry_fishman@acm.org>
X-From: git-owner@vger.kernel.org Thu Jun 06 16:09:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkasZ-0004Kb-3j
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 16:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab3FFOJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 10:09:23 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:55158 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3FFOJW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 10:09:22 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so390562lab.9
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/5orzM22FwLL1J9s3zU6ojTQZbdvw7VAX+tAlQJgihA=;
        b=fTjRexkjVnib+H3PX4fKmuUEWCwssO061XuOE9edZm8Xb2tLS64PsFp/d2uPCZH6+c
         M8ZktcQgatLmgx8GxoQNN7IuuuNBL+bBGODb9esQzLOv815M+IdEvGmKI93KNWCCE+zS
         TcyF8UbE84VfJaR4qB0U5nIagVt8m8sT9/mvc/kA6YnaUHn4Yg/+D7B+FG9xMhV445KD
         ZCugEhf6Lu4gzbT2VOLndrl0yS8MZ81+eEucHTvtjMGgr6AsqgcawfJVyTmmsOEoGTGK
         0+BFumzsYzt5n6RNvvHRXNuK3961Ovih60HEhUyEWnrJvOvoyj4UgPzgvYcxR3ckgTSW
         w+cw==
X-Received: by 10.152.26.225 with SMTP id o1mr17984501lag.43.1370527761188;
 Thu, 06 Jun 2013 07:09:21 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 07:09:21 -0700 (PDT)
In-Reply-To: <m3ip1rnygk.fsf@barry_fishman.acm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226505>

On Thu, Jun 6, 2013 at 8:46 AM, Barry Fishman <barry_fishman@acm.org> wrote:
>
> On 2013-06-06 09:01:48 EDT, Felipe Contreras wrote:

>> Nobody is judging the usefulness of a language, I have plenty of
>> arguments for that, but this is about popularity.
>
> I used "usefulness" in its general vague sense.  It is useful to be popular,
> I don't make choices solely on that or I would be writing everything in
> Java.

Straw man.

>>> Personally I would like the Git client to be packaged with as few
>>> dependencies as possible.  Right now that seems to require Shell, Sed,
>>> Awk and Perl.  The documentation has other requirements, but a prebuild
>>> tar file is available.
>>
>> I would be perfectly fine with replacing shell, sed, awk and perl with
>> ruby. But that's not what you are arguing, is it?

I don't know what you are saying, but it clearly has nothing to do
with the point.

Perl is declining, and it would be wise to use another language instead of it.

-- 
Felipe Contreras
