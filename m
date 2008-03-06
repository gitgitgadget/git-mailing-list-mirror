From: "Jim Raden" <james.raden@gmail.com>
Subject: Re: The 8th airing of the msysGit herald
Date: Wed, 5 Mar 2008 23:33:22 -0500
Message-ID: <5fc54b450803052033n66d43759y479f2cf2b9f8b990@mail.gmail.com>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site> <7v1w6rh1ru.fsf@gitster.siamese.dyndns.org> <46a038f90803031458t2b404212t10f6e9ae710dc408@mail.gmail.com> <47CF2F61.5060208@imap.cc> <alpine.LSU.1.00.0803060121360.15786@racer.site> <7vskz4heeg.fsf@gitster.siamese.dyndns.org> <5fc54b450803051803t4dda4341ue3ac403c742f1903@mail.gmail.com> <alpine.LSU.1.00.0803060327050.15786@racer.site> <5fc54b450803051842p4163df5do995f82eb17b3c5ca@mail.gmail.com> <76718490803052032m3dac9c14vc40b7d09fc4d271b@mail.gmail.com>
Reply-To: james.raden@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,  "Junio C Hamano" <gitster@pobox.com>,  "Tilman Schmidt" <tilman@imap.cc>,  "Martin Langhoff" <martin.langhoff@gmail.com>,  "Jakub Narebski" <jnareb@gmail.com>, msysgit@googlegroups.com,  git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Mar 06 05:34:08 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.249])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7ny-00037N-HX
	for gcvm-msysgit@m.gmane.org; Thu, 06 Mar 2008 05:34:07 +0100
Received: by wa-out-0708.google.com with SMTP id n36so6115685wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Mar 2008 20:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=3g+2isDxZvWYairXYJG3Tlh42iVbvfWwlPhquUvpWr0=;
        b=6rTf9huWWS8eGfr30gUjogTnVdH9A2JXYEUkyMTubaUlbph29dnlU0XOIh8+Biep+Pv6DVe4OwlaOhMRK5xQ2nsOodSnsMaYLFrUz4kJEaW0KoI1F+eDaAfdSx8MHbDGc8wtVG7ALqEKknJUAhBhIozRAng5XOjDpksoNpFizUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=DRsSc3iq3zpdXrlj8B8EEo93DvNi1Nc7hOt/a3jjv7tAXSCnIT1apvQ5B5EJbXF0sAjmAKEj9hKthQb1NAUVLVXTFQlclX58/vjTN1OvFWwn8Ep5qgYVXLo9mowlObNZcWDkdw0a8AGB+AhtNgUudAH97vQbhX3djmsjdvI6Hoc=
Received: by 10.115.78.1 with SMTP id f1mr170695wal.2.1204778005804;
        Wed, 05 Mar 2008 20:33:25 -0800 (PST)
Received: by 10.106.191.30 with SMTP id o30gr1924prf.0;
	Wed, 05 Mar 2008 20:33:25 -0800 (PST)
X-Sender: james.raden@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.179.1 with SMTP id b1mr1702773waf.4.1204778004650; Wed, 05 Mar 2008 20:33:24 -0800 (PST)
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.186]) by mx.google.com with ESMTP id v36si5644348wah.3.2008.03.05.20.33.22; Wed, 05 Mar 2008 20:33:24 -0800 (PST)
Received-SPF: pass (google.com: domain of james.raden@gmail.com designates 216.239.58.186 as permitted sender) client-ip=216.239.58.186;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of james.raden@gmail.com designates 216.239.58.186 as permitted sender) smtp.mail=james.raden@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by gv-out-0910.google.com with SMTP id o2so1487562gve.29 for <msysgit@googlegroups.com>; Wed, 05 Mar 2008 20:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=74rpv2sEPEvmN9obZ5ZEFz/jjOJCh8ZwJYccVc9MIxI=; b=GSi5oTxBXVkniU/0Yy5koWnFUg3YiQuPN1v3MG5pm43EYsIE7K4UpGxDYZBoajzd/X1uR38mcw0RMedDY+RuJ5pllJU0b3r7yhmGcHWeFjLEAm+EN6iF8kS/gXKjJtISmVpSkyELh5FiBHBKLchw+qN17wPbilHdPNnxpnxJMQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=qGT2JYT708gb5GdKo+y7Z/suAdhddQ7EsajJrTPzrqADI+y/dFZb5FHGI1tOIrVrRDXOhJNHXdg8PIrDghXXGj0Jp8s4+RNuOLZ+wWz5QRcuAG43BaOYfyO7F34GhvoMc1ttBn/YYd3ISRMVpsrlaq4bIH30oVMHHkkrsCzkUpA=
Received: by 10.114.155.1 with SMTP id c1mr6027782wae.105.1204778002550; Wed, 05 Mar 2008 20:33:22 -0800 (PST)
Received: by 10.114.198.3 with HTTP; Wed, 5 Mar 2008 20:33:22 -0800 (PST)
In-Reply-To: <76718490803052032m3dac9c14vc40b7d09fc4d271b@mail.gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76319>


Obviously I must have scared them off with my suggestion!  ;-)

On Wed, Mar 5, 2008 at 11:32 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Wed, Mar 5, 2008 at 9:42 PM, Jim Raden <james.raden@gmail.com> wrote:
>
>  >  Those 853 members are on msysgit or git@vger.kernel.org?
>
>  http://vger.kernel.org/vger-lists.html#git
>
>  Oh no, only 851 members now. They're dropping like flies! :-)
>
>  j.
>
