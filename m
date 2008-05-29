From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: How to merge branches except for one commit
Date: Wed, 28 May 2008 22:42:26 -0700
Message-ID: <216e54900805282242t1ac249bbv91e4166c72bbcd33@mail.gmail.com>
References: <216e54900805281932v1397fd30sad91f767175ba95e@mail.gmail.com>
	 <7vhcchrb43.fsf@gitster.siamese.dyndns.org>
	 <7bfdc29a0805282138kabc5417i4f67ae3995bf238c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 07:43:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1avX-0000SP-AT
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 07:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbYE2Fmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 01:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbYE2Fmf
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 01:42:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:48236 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbYE2Fm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 01:42:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2171166ywe.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 22:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vDQESaC5CGzV6LeaGB+tsPhnhNrKF98xFE5B+QC84EE=;
        b=nea6VGusyH7k2uDjTE7DJkNY0NdlEbthYdQZersCuBzja1KE0XwdhNAWkc3SvZpRnQtFpe8UcoP6COorC6pthHrsgclotmH8j3gawkQPZPp3gjJ4FKJBo+1D3W3p+NmoMjcnnYZGaqj/K8FrKGrxCqE7gqc0ChsxsDmbw60kDS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CXke13YO60xJZFAk9t7uVL8qE7O8/H2JJHLwAl4adB1bi8oa5TItachC0XeKt3gGhuDU9zx6wmm/QAGPez1vrSNK9vyH/gZQZWjQ/xHrq8uK6QNysHwOrzuh14IoSM4UXmAct3YcpH83U1RjWeqe6wRs3vY0Wx25OKHec2uajcw=
Received: by 10.151.155.21 with SMTP id h21mr4765522ybo.142.1212039746461;
        Wed, 28 May 2008 22:42:26 -0700 (PDT)
Received: by 10.151.154.16 with HTTP; Wed, 28 May 2008 22:42:26 -0700 (PDT)
In-Reply-To: <7bfdc29a0805282138kabc5417i4f67ae3995bf238c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83176>

Yes, thanks!

On Wed, May 28, 2008 at 9:38 PM, Imran M Yousuf <imyousuf@gmail.com> wrote:
>>
>> You can never plan ahead perfectly, so do not be too hard on yourself if
>> you occasionally screw up.  Cherry-picking from time to time is Ok.  With
>> practice, you will get used to it.  I juggle 5 integration branches to
>> maintain git.git itself and it took some practice for me to get
>> comfortable with the workflow.
>>
>
> I always wanted to know how you did it, thanks for sharing it :).
>
> Best regards,
>
> --
> Imran M Yousuf
> Email: imran@smartitengineering.com
> Blog: http://imyousuf-tech.blogs.smartitengineering.com/
> Mobile: +880-1711402557
>



-- 
Andrew Arnott
