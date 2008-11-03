From: "Abhijit Bhopatkar" <bain@devslashzero.com>
Subject: Re: [Announce] teamGit v0.0.4
Date: Mon, 3 Nov 2008 20:19:35 +0530
Message-ID: <2fcfa6df0811030649g743de15bmd266f10e78bf802e@mail.gmail.com>
References: <d62af2d5-4ba4-4fe6-9ecb-6df007f87245@s9g2000prm.googlegroups.com>
	 <vpqfxm9km1w.fsf@bauges.imag.fr>
	 <2fcfa6df0811030535m208999ben2608878fb0978fae@mail.gmail.com>
	 <20081103134654.GA13989@kooxoo235>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Ping Yin" <pkufranky@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 15:50:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx0lX-0002BW-Hs
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 15:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbYKCOth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 09:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbYKCOth
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 09:49:37 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:3453 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347AbYKCOtg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 09:49:36 -0500
Received: by an-out-0708.google.com with SMTP id d40so32043and.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 06:49:35 -0800 (PST)
Received: by 10.100.6.16 with SMTP id 16mr36266anf.108.1225723775160;
        Mon, 03 Nov 2008 06:49:35 -0800 (PST)
Received: by 10.101.71.13 with HTTP; Mon, 3 Nov 2008 06:49:35 -0800 (PST)
In-Reply-To: <20081103134654.GA13989@kooxoo235>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99948>

On Mon, Nov 3, 2008 at 7:16 PM, Ping Yin <pkufranky@gmail.com> wrote:
> * Abhijit Bhopatkar <bain@devslashzero.com> [2008-11-03 19:05:24 +0530]:
>> teamGit is a GUI for git,
>> in its final roadmap  it aims to aid small closed teams to use git,
>> currently its a pretty good frontend for basic git operations.
> Can it be used on windows?

I have just finished pushing some trivial changes to  make it compile
and work on windows, I tested it with latest msysgit and it seems to
work fine, although this really is just a 5 min. test.

You will need qt 4.4.3 with mingw toolchain installed to compile this,
i do not have expertise and/or will to create a installer etc. but
patches/additions are welcome if someone can take this up.

Abhijit
