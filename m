From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-bisect: call the found commit "*the* first bad 
	commit"
Date: Wed, 26 Aug 2009 14:10:00 +0200
Message-ID: <81b0412b0908260510nd69738axe8cd4e8fb3b63d@mail.gmail.com>
References: <20090826173850.6117@nanako3.lavabit.com>
	 <7vfxbfeyh5.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0908261207400.4713@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 26 14:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgHKO-0007tj-03
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 14:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757014AbZHZMKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 08:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756933AbZHZMKA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 08:10:00 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57036 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756904AbZHZMKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 08:10:00 -0400
Received: by bwz19 with SMTP id 19so67270bwz.37
        for <git@vger.kernel.org>; Wed, 26 Aug 2009 05:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gj4lPRjGisLY5sCeJQx/TQPwnXbU6HVw4AF2iqxA+PU=;
        b=dH/ULcPLLXSaTLQJFn464xoJyh1z9ys81F9dBwTK7FopIYN1YV+qESVv+PqnSdF/hP
         jOfagtN+5Qck/2Hn4hLR+X+XoViKmBOe5RE7uGWCKkfp4e+6m+u5fn9v55C3WyrDeejD
         rR18S0sVICCdiDosaXLFy9bTYBLtht6Nfg9UU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JPGV1lPVuJ78KjMnEQVnCao410nVkpX9XfsRFkSaqcPSklSAUk6Ei4VXR8d1InIQO6
         ayIk5H2njt8tOf7PF/rqdAAvsuzzF8cu3ZsZX3r0b6e/S+HwCM182mf7hxOrbV+D6idx
         J8A+BKMle7gEAEPv8xNSs6d1rGDLa+ldKdN1w=
Received: by 10.204.156.28 with SMTP id u28mr3574312bkw.144.1251288600695; 
	Wed, 26 Aug 2009 05:10:00 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908261207400.4713@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127090>

On Wed, Aug 26, 2009 at 12:08, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> On Wed, 26 Aug 2009, Junio C Hamano wrote:
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>
>> > .. as we learned in the school ;-)
>>
>> Thanks.
>>
>> Is it "learned in school", or do you also need "*the*" there?
>>
>> ;-)
>
> Well, I learnt at school that it is "learnt" and "at school"...
>
> double ;-)

There is not one native speaker in this discussion, BTW :)

http://www.thefreedictionary.com/learn
http://www.thefreedictionary.com/school (look for American
in "Translation")
