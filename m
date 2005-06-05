From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] git-rev-list --merge-order resynched with Linus' head
Date: Sun, 5 Jun 2005 22:55:59 +1000
Message-ID: <2cfc403205060505556fc7a833@mail.gmail.com>
References: <20050605072336.14283.qmail@blackcubes.dyndns.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu Jun 09 04:11:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgCVH-0002xW-NZ
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 04:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVFICOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 22:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVFICOp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 22:14:45 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:6497 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262004AbVFICOo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 22:14:44 -0400
Received: by rproxy.gmail.com with SMTP id i8so544169rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 19:14:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S1+kTXs8iwnOMDAJ5Ej1fZIfKpoPVtL6+x/UP0QXt2Z8StBic9I9IepS0TF34W+SD1Sk5+ltGInmgMVylg+ljGEUqCN+J1hwaW24vOkjwlWlcTnS3Qo2HL9AcEX9IHIBOoaCkmrFibNxUh+CGqrEWwklXFyO+ACS7XM9BdIJfFY=
Received: by 10.38.203.29 with SMTP id a29mr1911061rng;
        Sun, 05 Jun 2005 05:55:59 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sun, 5 Jun 2005 05:55:59 -0700 (PDT)
To: "jon@blackcubes.dyndns.org" <jon@blackcubes.dyndns.org>
In-Reply-To: <20050605072336.14283.qmail@blackcubes.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just discovered a few bugs in my revised patch...will repost when I
have fixed them.

jon.
