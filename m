From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] cgit 0.8
Date: Mon, 6 Oct 2008 00:22:21 +0200
Message-ID: <8c5c35580810051522l3c8fcfe4md8b78b569f287246@mail.gmail.com>
References: <8c5c35580810051310u60859afcvf38845244308cd23@mail.gmail.com>
	 <alpine.DEB.2.00.0810051346290.27691@alchemy.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Asheesh Laroia" <git@asheesh.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 00:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmc0k-0002tH-FS
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 00:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbYJEWWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 18:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755053AbYJEWWX
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 18:22:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:64286 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbYJEWWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 18:22:22 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2625925rvb.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=r1kSgm+BA9D1d0Vl++cr1QrOLn16sh3/Zr+SXZ6ApD0=;
        b=TMwyV4ehT+RQhtB8hPYVxkoItzt685/4EZeIC7JqGopO5S2CWL4rXnA3aDliCTEgiu
         P7Gdqomz6yarPRCnFcMDeN5UT239RpYHr1tePKWgo+NBIRDYvJw/5UEO2RGxnK3b7jjS
         RCr++2e6FzziHLBA0LiW7Hh+g1Wrk2KMjTYU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gZWbE/IWe2LeKPWDnAQ7hwsBVjpCDW6LFOutMFrprrMU9xyO95AWGOhbUajt8Fjqa3
         mgq1hd62eH3N9Wqe+gxp0dC+mP0Y+BlLdMCb5/lK9G9mq8Qkvhy4gR3YzNmV35FrCK2d
         KfLsG9h6U3VE9AHAjLoS4ALJPEE8LBFqy0Pls=
Received: by 10.115.74.1 with SMTP id b1mr4605454wal.169.1223245341661;
        Sun, 05 Oct 2008 15:22:21 -0700 (PDT)
Received: by 10.114.166.20 with HTTP; Sun, 5 Oct 2008 15:22:21 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0810051346290.27691@alchemy.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97545>

On Sun, Oct 5, 2008 at 22:49, Asheesh Laroia <git@asheesh.org> wrote:
> On Sun, 5 Oct 2008, Lars Hjemli wrote:
>
>> cgit-0.8, another webinterface for git, is now available.
>>
> I'm curious - is there any interest in the cgit world in providing gitweb
> URL compatibility?

Well, it's a request that's popped up a few times, but no patches so
far. It would probably be a nice feature if it could be done cleanly.


> Either way, thanks a bundle to all who work on cgit!  (And is this the
> canonical place to discuss it?)

You're welcome. And yes, I think this is the place (cgit doesn't have
a mailinglist of its own).

--
larsh
