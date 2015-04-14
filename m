From: Johan Herland <johan@herland.net>
Subject: Re: gitk won't show notes?
Date: Tue, 14 Apr 2015 22:53:21 +0200
Message-ID: <CALKQrgdxoO8eW9h1_+wDOp7Z0fjcqCWeFAyRjmsMUN+f1XUwnw@mail.gmail.com>
References: <551D99B9.7040200@ubuntu.com>
	<5523DE66.8060904@drmicha.warpmail.net>
	<5523E479.2010701@ubuntu.com>
	<5523E5FF.8060101@drmicha.warpmail.net>
	<55240F0A.80902@ubuntu.com>
	<5525164C.6000309@drmicha.warpmail.net>
	<20150411103156.GA5781@iris.ozlabs.ibm.com>
	<CAP8UFD1GRhjgcEomKN4mjxd-+wG0RabbTO=RTk1okCkU2u0FVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi7pw-00039X-UE
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 22:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbbDNUxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 16:53:33 -0400
Received: from mail14.copyleft.no ([178.255.144.193]:50848 "EHLO
	mail14.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbbDNUxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 16:53:32 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail14.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Yi7po-0003sF-ON
	for git@vger.kernel.org; Tue, 14 Apr 2015 22:53:28 +0200
Received: from mail-pa0-f45.google.com ([209.85.220.45])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Yi7po-0008nH-0D
	for git@vger.kernel.org; Tue, 14 Apr 2015 22:53:28 +0200
Received: by pabsx10 with SMTP id sx10so24548004pab.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 13:53:21 -0700 (PDT)
X-Received: by 10.69.26.67 with SMTP id iw3mr39724566pbd.151.1429044801620;
 Tue, 14 Apr 2015 13:53:21 -0700 (PDT)
Received: by 10.70.83.67 with HTTP; Tue, 14 Apr 2015 13:53:21 -0700 (PDT)
In-Reply-To: <CAP8UFD1GRhjgcEomKN4mjxd-+wG0RabbTO=RTk1okCkU2u0FVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267163>

On Tue, Apr 14, 2015 at 2:17 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sat, Apr 11, 2015 at 12:31 PM, Paul Mackerras <paulus@samba.org> wrote:
>> However, I agree gitk should refresh the notes in updatecommits as
>> well, but that will take more work.  Is git notes list the best way to
>> find out all the current notes?

Yes. (if not, that's a bug and should be fixed).

...Johan

>
> It looks like it is from the documentation.
> Anyway let's add some people in Cc in case they could help.



-- 
Johan Herland, <johan@herland.net>
www.herland.net
