From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: http git clone fails while ssh git clone works
Date: Thu, 3 Apr 2008 20:22:02 +0530
Message-ID: <cc723f590804030752k478a3774xdf9727ac22b3047e@mail.gmail.com>
References: <cc723f590804030440t14a8e4fdw77c4449dc2a4dbb8@mail.gmail.com>
	 <20080403125117.GG3264@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 16:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhQo5-0000yA-G0
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 16:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656AbYDCOwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 10:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757796AbYDCOwF
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 10:52:05 -0400
Received: from rn-out-0910.google.com ([64.233.170.186]:61643 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757062AbYDCOwE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 10:52:04 -0400
Received: by rn-out-0910.google.com with SMTP id e24so2078755rng.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/jM7aF75pCyrN8BZDGGDNT4EXGyTcekVuSaL3pZZSSo=;
        b=WkuUHSyPV7500wh9WGsBVXjpx1qhqOwPz1uePuPTDEI+nyviLVD+nNHQQQHSzPRvO1tQlIayYXmzNboJqLxhfdgCPaZloJEcJXha21bMCK2ibT88PKmNmxTWkfZDvecstrVIdezghJwBB1ptR61ngC7lJauhf1GdzgCe48oEu60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tOIS4jMUYgODfpncpkUfRYBggU2R0yLNbNboxfi7tRk3Z8/28gVo6DpR21sWIbG8F/aj8Y6Smd1BuYmVRfl5aS+Sj5CmaUsCp42BjC95jSK7RRzeihSy+0IQJDCg315LGmtYnfb/wwmRA5QaTJ4En2/K/Imu3e8lcj48JcVr1/U=
Received: by 10.114.171.1 with SMTP id t1mr17508958wae.124.1207234322170;
        Thu, 03 Apr 2008 07:52:02 -0700 (PDT)
Received: by 10.115.48.17 with HTTP; Thu, 3 Apr 2008 07:52:02 -0700 (PDT)
In-Reply-To: <20080403125117.GG3264@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78759>

On Thu, Apr 3, 2008 at 6:21 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Thu, Apr 03, 2008 at 05:10:07PM +0530, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
>  > while git clone ssh://myhost... works fine.
>
>  did you run git update-server-info?
>

yes.

-aneesh
