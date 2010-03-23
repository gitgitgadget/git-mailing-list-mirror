From: Howard Miller <howardsmiller@googlemail.com>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 14:24:59 +0000
Message-ID: <26ae428a1003230724o6b901e0s7d789f63d4718827@mail.gmail.com>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
	 <1269353235.14299.0.camel@kheops>
	 <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
	 <adf1fd3d1003230722t338c140an527b77f4023c9729@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: sylvain@abstraction.fr, git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Mar 23 15:27:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu551-0006Pe-2g
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 15:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab0CWOZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 10:25:03 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:38188 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab0CWOZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 10:25:00 -0400
Received: by ey-out-2122.google.com with SMTP id d26so608479eyd.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=e9eS6zCB0aPALsdypoepi4uKzLw4Jr5F2KwM5I9GkjM=;
        b=EAu+RXxYg59QM1Bqtb9UTFOCEoOLj/t81iAGvFM6SOPBQhgPLI/UY1W/uNAndX+KtP
         CXj63i/kWPE4orKML9IOhrRUPFgkCos9kaQ4qkF0+FPLnuTdqvutQI+cx6LkcOsmemvQ
         gWC5QnMgy1jSP53D3/yT1vt7Jyh2X2VdeI7wM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NTSbs3J3OfYBWFNsWoHFRbgyythMcXIuvlcAObc9XwskyZCCcJw86it7x0pWLlFKHW
         lzkyW8yvfsjWlX1/+lE5F09i2xhSpcGMMhqj3QusIpFhKjGghNqzFvyv47d+9rP8VJXQ
         XSkc5BtrrshGb1qjuPJZV3wRXe9VQqd2QKqAU=
Received: by 10.239.187.67 with SMTP id k3mr2090685hbh.50.1269354299457; Tue, 
	23 Mar 2010 07:24:59 -0700 (PDT)
In-Reply-To: <adf1fd3d1003230722t338c140an527b77f4023c9729@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143019>

>
> man git-push and search for '+', there is even an example like the
> command above.
>

Not on my docs (1.5.4) but it works anyway. Thanks!
