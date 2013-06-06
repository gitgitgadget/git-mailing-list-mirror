From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 08:01:48 -0500
Message-ID: <CAMP44s0M5tsN+zYoa_HC+8SLqyvDUBi_wuiOGyQWo0XWbWXC-A@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<CAMP44s012ccmaArrTbfy_xNrqbnOjVGTnY+po9cE8JGh_U72Gg@mail.gmail.com>
	<CANgJU+W1BLOB_TuMa_zRHtCW-8Ge8nu_kK=5qu2xDY=Km_kk4A@mail.gmail.com>
	<CAMP44s3zuDPTApPvnaC0bzqmAUkRRwePZDRL4syB=tM3d6eiBA@mail.gmail.com>
	<m3d2rz5svw.fsf@barry_fishman.acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Barry Fishman <barry_fishman@acm.org>
X-From: git-owner@vger.kernel.org Thu Jun 06 15:01:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkZpD-0002ka-3f
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 15:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053Ab3FFNBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 09:01:51 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:58571 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932940Ab3FFNBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 09:01:50 -0400
Received: by mail-lb0-f172.google.com with SMTP id p10so3050195lbi.17
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EZb/aNYsqFtFz7WMx1lROftTwyxjtfoE8eOH+DztukQ=;
        b=UVqGXyoOJs5y7wXFeaY3HyvaovLYMo5UdO8W6BrI7YSdddrYih48xqF2UbBxs9/wl5
         bT/MJy+kVPoqPEj1f2AKfaNknSvJl+G7puNijdbBrUd90B0v0nApUbQcp+WK2JpSAXTG
         k9nwRtZLoiycSMuHL8iNqDGDdw/5wv/JodfckscTP+apCHp5+dU6WaWrDcOMejU+xf2A
         4e1fVmF5655YsKmQo/kqKhLFyIS3IEB6URk0MCNF/Jo1u/gDMzz1w1gZSn8qTAT4fRpc
         iAXJ4/AqYZQvp7b4jWoRnFsKt1CuwLbDWqZ9fXiRnFwcO35EABmHK8hCDNaOql/o5o6b
         +qdg==
X-Received: by 10.152.26.225 with SMTP id o1mr17804212lag.43.1370523708796;
 Thu, 06 Jun 2013 06:01:48 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 6 Jun 2013 06:01:48 -0700 (PDT)
In-Reply-To: <m3d2rz5svw.fsf@barry_fishman.acm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226503>

On Thu, Jun 6, 2013 at 7:24 AM, Barry Fishman <barry_fishman@acm.org> wrote:
>
> On 2013-06-06 03:46:59 EDT, Felipe Contreras wrote:
>> On Thu, Jun 6, 2013 at 2:26 AM, demerphq <demerphq@gmail.com> wrote:
>>> Good thing you are being objective and leaving out the Python 3.0
>>> mess, the long legacy of backwards compatibility in the Perl
>>> community, the active community behind it, its extensive portability
>>> support, and fail to mention the lack of an equivalent to CPAN. We
>>> wouldn't want facts to get in the way of a personal bias would we?
>>
>> None of that has anything to do with Perl's popularity.
>>
>>> Just thought I'd push back on the FUD. People have been saying Perl is
>>> going away for decades...
>>
>> Perl has been going away for the last decade [1], and will continue to
>> go away. Perl is going away, and that an undeniable fact, and if you
>> are not interested in discussing on the basis of reality, I'm not
>> interested in discussing with you.
>>
>> [1] http://www.tiobe.com/content/paperinfo/tpci/images/tpci_trends.png
>
> I don't think the usefulness of a language should be judged by hits on a
> web site.

Nobody is judging the usefulness of a language, I have plenty of
arguments for that, but this is about popularity.

> Personally I would like the Git client to be packaged with as few
> dependencies as possible.  Right now that seems to require Shell, Sed,
> Awk and Perl.  The documentation has other requirements, but a prebuild
> tar file is available.

I would be perfectly fine with replacing shell, sed, awk and perl with
ruby. But that's not what you are arguing, is it?

-- 
Felipe Contreras
