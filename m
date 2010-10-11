From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/5] Documentation: gitrevisions is in section 7
Date: Mon, 11 Oct 2010 22:49:06 +0200
Message-ID: <AANLkTimioZVvsu4GD=8dJBrWsg-=N+w2YDSGm29d9MhS@mail.gmail.com>
References: <20101011150342.292ad725@chalon.bertin.fr> <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr> <20101011160224.GA25842@burratino> <20101011160332.GB25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yann Dirson <dirson@bertin.fr>,
	=?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 22:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5PJM-0000fM-Lo
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 22:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab0JKUt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 16:49:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41201 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126Ab0JKUt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 16:49:27 -0400
Received: by gyg13 with SMTP id 13so942682gyg.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=wFKsTIDquXcgPnRFRg7zHQ37FFyzX5+/3xGouGDkHHM=;
        b=w3XDvrmeA/pLLptDH8fGrDNgsMelZ1vjV7/q7l67VcCw+Xi4nqkqInHz75cdC4y8wU
         3OMC36UvDUcuG7uZu1LsX736d3ZQeb6YOkPZjBuhzhYsvds9tYW5UmKMWh2pcW+jexHZ
         bvXoPqwxucdi9N5Eq6gl9hGpGs7guLT0iQr2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=cMnY02EbHf2Q4Kyh78n/1OAqYRSXyUSBKvG3vX0WOhCi8WwR7HqaxL8WXrZDiyhO3m
         jpFgT602wqHCGsIyxpgSPf1QF9aNNqC8LLCw9N7LL3F4RtocONi3pUG2ysLvjnYiJFCX
         TAjhw1sCnSaB/hLNUnSUNiEFUtc7014ZqEsy0=
Received: by 10.150.147.11 with SMTP id u11mr7225095ybd.386.1286830166434;
 Mon, 11 Oct 2010 13:49:26 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Mon, 11 Oct 2010 13:49:06 -0700 (PDT)
In-Reply-To: <20101011160332.GB25842@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158788>

Heya,

On Mon, Oct 11, 2010 at 18:03, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Fix references to gitrevisions(1) in the manual pages and HTML
> documentation.

Nice catch. How did you find this? Have you check there aren't similar
references that are wrong?

-- 
Cheers,

Sverre Rabbelier
