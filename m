From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #01; Sun, 1)
Date: Mon, 2 May 2011 19:43:04 +0530
Message-ID: <BANLkTikzXhk9u4oXckXPwrkKqKq-rNXdmQ@mail.gmail.com>
References: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 16:13:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGtsR-0006im-49
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 16:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757775Ab1EBON0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 10:13:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44536 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab1EBONZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 10:13:25 -0400
Received: by wwa36 with SMTP id 36so6377930wwa.1
        for <git@vger.kernel.org>; Mon, 02 May 2011 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=BNkJZSkHSHkAf/MVWAsIS+rDBoLnrsK40MxfNNDXPSk=;
        b=j04aXPDEJc5yVRa/atsX5fmFjF1XtwpTVL9xbIEQDnUc808aDTg8j4WhLDtl1cKqoi
         ggVA/kRjwf4teqBAqFrmRx07CZ0mDaKIPAO8dJApy6tgys2CZdtE16XhBraNckDkjDYc
         cT0YGoo6u1cnBmDzJEOJB6PFVvY4IKuzRU78M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RrGB0I8+nBKlTNSxifvbV72IoOkcsDgWRXdzF4kWmeScARPhTFC0jvk3NNhLN3x0+e
         Pbgy5SgYfbfW8dnQfgwmqL8qJOD9P4RsuIe6IRtO3PklP3ehz4xRw6sU5Pv6GM18x2/9
         c/J2spCVHEjICc04zKFS81HV6N3a+BqwvvNpQ=
Received: by 10.216.236.157 with SMTP id w29mr2784692weq.18.1304345604223;
 Mon, 02 May 2011 07:13:24 -0700 (PDT)
Received: by 10.216.3.72 with HTTP; Mon, 2 May 2011 07:13:04 -0700 (PDT)
In-Reply-To: <7vd3k2q8lt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172592>

Hi,

On Mon, May 2, 2011 at 5:25 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * rr/rerere-clear-libify (2011-04-13) 1 commit
> =C2=A0- rerere: Expose an API corresponding to 'clear' functionality
>
> Jonathan had good comments on moving the garbage collection interface=
 as
> well. Perhaps needs a re-roll.

Definitely. Will re-roll soon. Sorry about the delay.

-- Ram
