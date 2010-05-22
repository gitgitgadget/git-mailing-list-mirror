From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSoC] git-instaweb: Configure it to work with new gitweb  structure
Date: Sat, 22 May 2010 21:56:37 +0200
Message-ID: <201005222156.37919.jnareb@gmail.com>
References: <1274523105-3327-1-git-send-email-pavan.sss1991@gmail.com> <201005222059.54995.jnareb@gmail.com> <AANLkTikSJQ7MMWytdMjJwaP1YBV1lebo4f7I4OUOIXAV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 21:56:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFuoQ-0003xd-Cv
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 21:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758048Ab0EVT4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 15:56:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40870 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab0EVT4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 15:56:39 -0400
Received: by fxm5 with SMTP id 5so1634211fxm.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pb13hOzNzVG4wOLmYbYnDf9dBL92JlTfcV4wX5ZSD38=;
        b=uQ3sH1AjxyFuLbKtAZt2LmKLSrCr5xPwVhbs9I9XOMQYFqJjsnarNiuEs/K+Gfetww
         1esKvO3OpqEYCCB0ZmFBVYJ1Df0d1cJJR0cTBlI4jEc3KLgHngBmY4/Yc3cK7ogR2rK2
         byUiWQqOB0LudwCMm4DnnjXMPABWQmSRiAJ7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fM4BGdRfVeSSZqZzWZt8+lkD4BDa4buaP4Agzp9taUlgqGTxi1H5MyOPF3QZu8NxZq
         ng387LF3rp0KDIL3VD9Xolmw5koh3OBYGadXU+zG7o14tLmjNKgoEsXqss7tZMI6PZd4
         t7Ak7PH6KNP4wW0wvk33XrGj9wmikBlQoIjng=
Received: by 10.103.50.13 with SMTP id c13mr2768445muk.63.1274558197644;
        Sat, 22 May 2010 12:56:37 -0700 (PDT)
Received: from [192.168.1.15] (abwk129.neoplus.adsl.tpnet.pl [83.8.234.129])
        by mx.google.com with ESMTPS id g1sm8749444muf.0.2010.05.22.12.56.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 12:56:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikSJQ7MMWytdMjJwaP1YBV1lebo4f7I4OUOIXAV@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147540>

On Sat, 22 May 2010, Pavan Kumar Sunkara wrote:

> Do you want me to make that change to and send the patch again ?

Yes, I would like you to.

And push this change to your repository after it is accepted as a final 
version. TIA.
-- 
Jakub Narebski
Poland
