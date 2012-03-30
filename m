From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: SVN Branch Description Format
Date: Fri, 30 Mar 2012 09:36:49 +0530
Message-ID: <CALkWK0mh5hKz+=-Ur3bE2+YBiSwFiPtZXQOJdMwY=BemXrqwWQ@mail.gmail.com>
References: <4F5C85A3.4080806@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 06:07:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDT7v-0000MO-0H
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 06:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840Ab2C3EHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 00:07:13 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55193 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab2C3EHL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 00:07:11 -0400
Received: by vcqp1 with SMTP id p1so148786vcq.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9PDdQy0Wfu4ZLLxCngNywbE81AezJoW67e5nWSv5jKE=;
        b=bNgw+VPNLdSEyOHmr+wpkGnJtRbFQeFCSXtDCye+ZX8HGlqPM/QGGkVpQyZ+m3+vso
         3JTJ1CmDiuRXdDIepHjyfpHQ2agGW9wOqhI1iSSgg8Wes+Ab7//wb2yvNIcVNL/A7+nS
         /6sQ25eSYUmONzF/GK+n/IDRRS5w+E+9/8HnoGMoiCvuX2Y93XwAMgeE9um/qy40GaEY
         mDYFi1PPQ5m4EUz7b4b/cBvZtwZ5y8+ydzRB4eLC8Jv8n47udZ546zzyzvQDviRpXrDk
         g+xBOFSBdcfq3NXBBLUgJjVnRbZ+UG/4w+W+3BW1rPlT/Aud4+XVxC8IKrc6G8A5rct/
         Pxdw==
Received: by 10.220.155.7 with SMTP id q7mr316633vcw.71.1333080430870; Thu, 29
 Mar 2012 21:07:10 -0700 (PDT)
Received: by 10.52.29.237 with HTTP; Thu, 29 Mar 2012 21:06:49 -0700 (PDT)
In-Reply-To: <4F5C85A3.4080806@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194322>

Hi,

Andrew Sayers wrote:
> SVN Branch Description Format v0.1

I found this pretty interesting.  Doesn't it duplicate some of the
functionality of reposurgeon [1] though?

[1]: http://esr.ibiblio.org/?p=4071

    Ram
