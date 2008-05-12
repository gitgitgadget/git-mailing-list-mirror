From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH 2/3] A simple python script to parse the results from the testcases
Date: Mon, 12 May 2008 12:16:37 +0200
Message-ID: <bd6139dc0805120316oe704c8ek149d37552d72ab30@mail.gmail.com>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
	 <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
	 <m3hcd34ynv.fsf@localhost.localdomain>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dsymonds@gmail.com
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 12:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvV5z-0000qH-8g
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 12:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758681AbYELKQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 06:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758202AbYELKQi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 06:16:38 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:29749 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758609AbYELKQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 06:16:37 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2250360wfd.4
        for <git@vger.kernel.org>; Mon, 12 May 2008 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=0DgKoGQHorRKV3LZi3/zhUximQWZ4PLrx55/0ycuZKk=;
        b=IDEH/noJZpH4To6TvAlMDOAUGWZpb9zSrMfhA2iXbac83Bqh1rscnbQIqNc6rp5ouEILcDF9J8NGWnkgfjDkZoOChH5vXLmBED8NaoDfvwSSPL1tvGTlm1tt5RdtLGm13VZp/rNY4mh4TdYRE2BHQ8AY4z7NfBaLEB9Z70FIryA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tFiZrJVo2D6uQSjr8YdbJtv3w3DQWIxPL9kl4zqLq3PUnH3D8IYnmrQ/Woko0vTQTwir15pxvdI/sw1SN1TWQ8R8XLaQqVIA4eJEncrTFV9MGcGBm1Z90K1FzCr9jO3Au96im1m/yXWyjl6mEHli3DOQ6y7+W5x22dBX9SUCw9Y=
Received: by 10.142.217.17 with SMTP id p17mr3197963wfg.99.1210587397307;
        Mon, 12 May 2008 03:16:37 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 12 May 2008 03:16:37 -0700 (PDT)
In-Reply-To: <m3hcd34ynv.fsf@localhost.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: 5c9a3d3cf2d68679
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81849>

On Mon, May 12, 2008 at 12:14 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Or Perl, as Perl was created for that.  I'd rather don't reintroduce
> Python dependency...

I'm sure Perl would work just fine, except that I'm not good with Perl
either. If anyone feels like writing up something in Perl I'd be happy
to test it and send in a new patch with the Perl script.

-- 
Cheers,

Sverre Rabbelier
