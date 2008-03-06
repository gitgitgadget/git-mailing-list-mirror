From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: The 8th airing of the msysGit herald
Date: Wed, 5 Mar 2008 23:29:09 -0500
Message-ID: <76718490803052029n52e739bby6009eea14c063891@mail.gmail.com>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site> <m34pbok54h.fsf@localhost.localdomain> <alpine.LSU.1.00.0803030052450.22527@racer.site> <200803030210.02223.jnareb@gmail.com> <47CBE85B.6060702@imap.cc> <7vablfiv42.fsf@gitster.siamese.dyndns.org> <47CC432B.8060502@imap.cc> <7v1w6rh1ru.fsf@gitster.siamese.dyndns.org> <46a038f90803031458t2b404212t10f6e9ae710dc408@mail.gmail.com> <47CF2F61.5060208@imap.cc>
Reply-To: jaysoffian@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,  "Junio C Hamano" <gitster@pobox.com>,  "Jakub Narebski" <jnareb@gmail.com>,  "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,  msysgit@googlegroups.com, git@vger.kernel.org
To: "Tilman Schmidt" <tilman@imap.cc>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Mar 06 05:29:53 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7jq-0002Hs-3g
	for gcvm-msysgit@m.gmane.org; Thu, 06 Mar 2008 05:29:50 +0100
Received: by ug-out-1516.google.com with SMTP id 1so3227704uga.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Mar 2008 20:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=nFSc0PODlpQp9x4ln/eE86U6+jLxQRdxbdJTfqT6wj8=;
        b=Yi/W2sdf/iB8wz85G4PN3+4T4AItIoqX2GoGibh9+ncLwNU15Uvh/1h25FwgRGVrpcJ5JI9BKCmSirvnREup3cT4BOXBKyCLGNBT6A4njrodXQrUAM2b9WALL5Kitm+cwjuzR+HZ4wTV8Xy4Vp607YCQvzr8ojyQ7/as0He5niU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=FWDqkI3fQCIMARYlCfYL33/Sh8DaJVC1jgBt0OZytSX+ZKz9vB3cRQ2VLWGOeAfdcqvStCobYHA6uDREZkNfMhmv5enKNCnbzvLkcgY8+7PrcubGAFumNAWgdWaUDY2YoEhRwISwIqwg2Ok78/i+4bUCAOQUCAQ7Cw/evmHR21Y=
Received: by 10.115.48.12 with SMTP id a12mr170118wak.10.1204777752452;
        Wed, 05 Mar 2008 20:29:12 -0800 (PST)
Received: by 10.106.177.2 with SMTP id z2gr1922pre.0;
	Wed, 05 Mar 2008 20:29:12 -0800 (PST)
X-Sender: jaysoffian@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.75.1 with SMTP id x1mr1712162waa.6.1204777751884; Wed, 05 Mar 2008 20:29:11 -0800 (PST)
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.190]) by mx.google.com with ESMTP id k36si5317655waf.1.2008.03.05.20.29.10; Wed, 05 Mar 2008 20:29:11 -0800 (PST)
Received-SPF: pass (google.com: domain of jaysoffian@gmail.com designates 64.233.170.190 as permitted sender) client-ip=64.233.170.190;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of jaysoffian@gmail.com designates 64.233.170.190 as permitted sender) smtp.mail=jaysoffian@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by rn-out-0910.google.com with SMTP id s28so817998rnb.20 for <msysgit@googlegroups.com>; Wed, 05 Mar 2008 20:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; bh=1tJ17Yb4Mm3mdDzIV+O/VbUlpbdXWHwW/UA2xwyy2ls=; b=wZO/X6ZHX+yOFgmGzCRsL7G+K+yc6biSF7mv71bGPmn/xIRMgC1nG2SxFxCsOjdVAtMAXtCfHX7Z1MuebTZnH9422bVF1w6QyeAcAlnxz1z9DT3KiWOju+8VKvEUFbytrKpiZZrOwLLPqbG0ZXlvUUoFUJO89DdfSjzrqgbvBfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references; b=dCP1H82v3kUiPHGb4l0Zoiq31Gb68pD/Iw7yd8e8F9GtgxA+xEwT+DGS7ESx5uVLrEsiAnqPyT1NKysFxP8cqXwLe4v6syecYhSaQ9SAySGh5HZ1f42Eg8ItVzpZSK1H9PBfNvE3xK9nuwH2qN9HAeC9UzrVvOeA9qfBF9tHZdk=
Received: by 10.114.195.19 with SMTP id s19mr2159077waf.57.1204777749318; Wed, 05 Mar 2008 20:29:09 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Wed, 5 Mar 2008 20:29:09 -0800 (PST)
In-Reply-To: <47CF2F61.5060208@imap.cc>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76317>


On Wed, Mar 5, 2008 at 6:40 PM, Tilman Schmidt <tilman@imap.cc> wrote:
>
>  But I'd like to suggest something else still: seeing that my git
>  mailing list folder has already grown to 363 mails again, of which
>  probably only a small fraction will concern me as a user - would
>  it be possible to have separate mailing lists for usage topics and
>  for discussions of ongoing development? I imagine that might help
>  those who just want to use git (like me) to find their way around.

The mercurial lists are split-up this way. I hate it.

As for wanting a git-users list, just try filtering out everything from this
list with PATCH in the subject and you'll have a close-enough proxy, IMO.

j.
