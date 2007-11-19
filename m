From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 18:04:11 +0100
Message-ID: <8c5c35580711190904v5975e81k3d515dc44fee9c21@mail.gmail.com>
References: <1195477504.8093.15.camel@localhost>
	 <8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
	 <E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jonas Juselius" <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: "Benoit Sigoure" <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:04:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuA2x-0008AQ-2O
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbXKSREN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbXKSREN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:04:13 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:56754 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbXKSREM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 12:04:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2039634wah
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 09:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nAGwNoA051uxrK6Sjdcw+AHr4ahiY709fubYegRX7Lc=;
        b=W7j75/5efMAA4sxVxu1DouYeWandI7cf9hQelTcuLFy0AWO5hk7uITtyaNaAxTpFbNOJJKE7vAosQX/hu7gQ57W1c4Efal2pz3e67jMKpVZ203o7W2mMzVRZ45V2/K9EaxCN1aGuAT99v0EgOafaa2ve31svG+IOlGJEOhgfFxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nyGmLQlLHvWzVAiTEAckHLKO0vExoC7yzXbeSZUu9gOzE9voWQpE6bNtkBdvG7H07YExZkh4Yv2QSSI9UZR7gbwpZL0xU+mF4R1zM4M4wNGNmkFDIDkFZUR9+XfoLg1v8sG3oAwSkOQXgtN4hqIk6uzll/avMV5/T/bk99Ks/xM=
Received: by 10.114.175.16 with SMTP id x16mr1099779wae.1195491851480;
        Mon, 19 Nov 2007 09:04:11 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Mon, 19 Nov 2007 09:04:11 -0800 (PST)
In-Reply-To: <E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65470>

On Nov 19, 2007 5:57 PM, Benoit Sigoure <tsuna@lrde.epita.fr> wrote:
> Understanding this is very important because ``error humanum est'',
> and people happen to screw up their hard work and they don't realize
> that they can go back without even knowing what the hell the reflog
> is or how to use it (I personally don't know -- but I'd like to, give
> me pointers please :D).

You can simply try 'git reflog', and then 'man git-reflog' ;-)

--
larsh
