From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Git-to-svn convert
Date: Thu, 20 Dec 2007 12:54:59 +1300
Message-ID: <46a038f90712191554t2c1adc79s7948c7002c145143@mail.gmail.com>
References: <476997C1.2080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Andrew McMillan" <andrew@catalyst.net.nz>
To: "Thomas Harning" <harningt@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J58l6-0005fW-I9
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 00:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbXLSXzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 18:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbXLSXzE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 18:55:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:20279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbXLSXzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 18:55:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so379027ugc.16
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 15:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=z5WexCINbiBjA2ClRxPrKYpxQp93L8fK9UnRNWTaVI0=;
        b=NS4G9IDubFjVIcrnBgCHINs34wTQNrBWlUoxb86TAWH/njgQrwyQEGkbd1Hua3T+O0uOYL7+xyYbWKg7Z8Eto84a/Uf4G9BZnnK4xlfOs0VWC78LYYEymF0Ynl75rDICEazbM64gav6GquxNaTyh1ThIBStf2Ktn2lGQfI7Sz1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HT17b1qABRUjIUreVfKoBzdaT5FNh3kbp++XD++2DDsVPCS9t6SYVE+/CPx/NpfxU1ZH5cADf/WDvMOoz1ZHtWcS/7QtAnuiA3KVwippy0Q1yTRs5OJzJm7gbzJE7Out1kNkXb4Ho0pB28BfcnRA0d2VZB2/aE1Lt10Utr6qrOI=
Received: by 10.67.15.8 with SMTP id s8mr2786653ugi.42.1198108499829;
        Wed, 19 Dec 2007 15:54:59 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Wed, 19 Dec 2007 15:54:59 -0800 (PST)
In-Reply-To: <476997C1.2080506@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68960>

Hi Thomas,

I think Andrew McMillan had written a few scripts to "export" a git
repo to SVN and CVS. Not sure whether the code is public. But at least
for a while, the Mahara project was using git with SVN and CVS
"readonly" exported repos, a bit like the BK->CVS of yore. He may have
been using git-svn though.

cheers,


martin
