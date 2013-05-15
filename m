From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] make color.ui default to 'auto'
Date: Wed, 15 May 2013 14:41:03 -0500
Message-ID: <CAMP44s3hk38iKzKw=r9MqNh_dyG5q7NVdO2iQc9jMurT+H8QcQ@mail.gmail.com>
References: <vpq61yky2zp.fsf_-_@grenoble-inp.fr>
	<1368619757-10402-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vy5bgckr4.fsf@alter.siamese.dyndns.org>
	<vpqhai4fbsn.fsf@grenoble-inp.fr>
	<7v8v3gcfk1.fsf@alter.siamese.dyndns.org>
	<vpqwqr0azz7.fsf@grenoble-inp.fr>
	<7vppwsazg7.fsf@alter.siamese.dyndns.org>
	<vpqli7gayts.fsf@grenoble-inp.fr>
	<7vhai4ayby.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 21:41:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UchZW-0002h5-O4
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 21:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab3EOTlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 15:41:06 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:48698 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab3EOTlF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 15:41:05 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so2307302lbi.18
        for <git@vger.kernel.org>; Wed, 15 May 2013 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Q9VQGiOijjAEqqtYx7aaComeP3tGRwDBdH6N1mJQciY=;
        b=tD+afDAP1MTTf3v0ww5hAwO4Ta3ZSr1t+LM5bMakVUREe29KO/rKlPh+KvIkvHCvF9
         yfuV3Q+dR09y5XsJhWpFoIElNmP4x2Qdz9JovvqEDfBSKg/qfZKhPXTM3sMr2qEOD63m
         P2t3R97XYoq74m50u4Dt/UoDel5nq3DQZrVo8bQlmCOygsdn0Odvjt7QGTLLFGaUh7pV
         9CVh6D8yVSBcpPqhJKzP2JQTMSbutk3Lzfd3l49Bulm4yjv+jGDu9hqhdaRh56AWE8ut
         Bk9TvThPTAsxXE923KUmoCf2Xeril2TstEfqt8oFBIzl9Kjm9Eph9eJFU2gJ6hb0RriR
         ha3Q==
X-Received: by 10.112.166.101 with SMTP id zf5mr18070156lbb.59.1368646863850;
 Wed, 15 May 2013 12:41:03 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 12:41:03 -0700 (PDT)
In-Reply-To: <7vhai4ayby.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224443>

On Wed, May 15, 2013 at 1:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> We should be honest and say what we are doing: "it will make things
>>> easier for majority while making it less convenient for minority".
>>
>> I thought this was what I did, but your first complain was I was
>> mentionning the majority, and you are now suggesting something about
>> majority/minority, so I'm lost.
>
> Not really.  My main complaint is that you were making it sound as
> if the inconvenience for the "majority" is very severe with "many
> not discover", "live with", and such phrases, while making the
> inconveience you are placing on the "minority" trivial with "easily
> set" and "already tells them".  That sounds a lot more like making a
> lame excuse than doing a balanced analysis of pros and cons of the
> change.

I could barely parse this, but I've found that many colleagues didn't
know about this configuration. And I don't see why anybody would not
want this. The minority that don't want this can search the interwebs
to find out how to disable the unwanted behavior, so the majority that
do want this don't have to enable it all the time (*if* they know
about it).

-- 
Felipe Contreras
