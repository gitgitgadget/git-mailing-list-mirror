From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: [ANNOUNCE] Git-1.6.0.2-preview20080923
Date: Tue, 23 Sep 2008 17:28:40 +0200
Message-ID: <1a6be5fa0809230828q66b97aafkf9ac5f92d7d1a2d0@mail.gmail.com>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
	 <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de>
	 <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
	 <200809231554.15113.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johan Herland" <johan@herland.net>,
	msysGit <msysgit@googlegroups.com>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Sep 23 17:29:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki9po-0004sC-J8
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 17:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYIWP2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 11:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbYIWP2n
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 11:28:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:32194 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbYIWP2m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 11:28:42 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1640282ugf.37
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uBB64nRHltB6YTqs/iHNTed6p6rwhX8eJDY1K88fa6c=;
        b=K37wjAcyBfYCNbmB1f84qhU6saI1Gf/emr+QdyJtQzODX8LegdcGxZMOUDIrxTCUxr
         DFqwBUo5uOns4QBtOL1PK+MdGq8dg00r6VOc6s5TWVdUmzyYOyuIpiiPj4G5Y4BKJdbB
         e/EsrN989WiqFm0MiRS5a6zCshxCpSYdxT4kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xsdhMAHYxCaqYjjFFun+9KUNmEw4WUT8+aXd4XdG0mzW6yEgIsB6608KU7634lFWuK
         BFTLO6wcyYm7nnaBxN80MwLJSpw+nENRaqpjvvMaJuK/tnQwOFZ/U7GjQTkesH2u7MuA
         5bJMKUeNF3Eoc4AFvFhwKGoX+hmN3FKAiwksI=
Received: by 10.86.52.6 with SMTP id z6mr6230422fgz.18.1222183720368;
        Tue, 23 Sep 2008 08:28:40 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Tue, 23 Sep 2008 08:28:40 -0700 (PDT)
In-Reply-To: <200809231554.15113.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96575>

On Tue, Sep 23, 2008 at 3:54 PM, Johan Herland <johan@herland.net> wrote:
> On Tuesday 23 September 2008, Steffen Prohaska wrote:
>> On Sep 21, 2008, at 7:33 PM, Steffen Prohaska wrote:
>> > Git-1.6.0.2-preview20080921 for Windows is available at
>> >
>> >   http://code.google.com/p/msysgit/downloads
>>
>> I updated the installer to Git-1.6.0.2-preview20080923.
>> The problems reported on the mailing list during the
>> last two days should be fixed.
>
> Confirmed. SSH works again. :)
>
>> I apologize for the quality of Git-1.6.0.2-preview20080921.
>> It was unacceptable.
>
> You have absolutely nothing to apologize for. I highly appreciate the
> effort you and others put into msysGit. :)

I second that!

-Tor Arvid Lund-
