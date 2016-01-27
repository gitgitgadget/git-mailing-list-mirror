From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git for windows
Date: Wed, 27 Jan 2016 16:32:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601271531190.2964@virtualbox>
References: <56A8AAD6.4070404@gmail.com> <56A8AB7F.8040101@gmail.com> <56A8AF5F.5030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrey Chernyshov <chernyshov.andrey@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 16:34:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOS4z-0003Uz-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 16:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933420AbcA0PcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 10:32:12 -0500
Received: from mout.gmx.net ([212.227.15.15]:56863 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933054AbcA0PcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 10:32:10 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lk7fW-1ZnTMY1YbK-00c5sV; Wed, 27 Jan 2016 16:32:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A8AF5F.5030707@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:a5Jhf2b6COiqbec1Ji2JQw2NEThjQBHsWWU0WHQ+ctJT6X9YUEj
 q3eL+nny16Isn1OEC3yjXsxAvla0l9695R2/kJsfQsHI7dk+AIIbysJl+mnvCBhwPJWze/V
 wgANjbRZOVnLVuyAt+p5W5baebY8T8zoB7Fu5JHEqWl/Drz2iB3fNGrRsj4haklw3ANxedw
 aw3WhZAKSJpdz8hJcbuWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kp5lpsQWAcM=:mmyyyJQdqjhsd4UB6KAGg9
 9KarWF+/edYPCly0wty5iKvJYzCGr0xTantRF2/UZYHWZQTHcw3hCvPSlmba4WroqlIYNtn9j
 oi3HWoCEOqknZeMXmN9Bzbl4hdF8Od5YegvMQ9aHyTaVguSgck0csAm1bFqeA9881Y86AP7+a
 ctipcKGdXXKcBL+OgB3ZJK31aG2tjSEpheCAm3BWnHf6U4I35TN0XNh6L/VEoylhNM8qgXBoX
 rg7LCkPLD6oQ+icrSv1gdpiAI83GS02L6FAIYy6zhn4ESKgH4zvgp9TwTJqQk0RoglTHqfwqy
 MyDExKIrH7J29vEM5sX6xQdslen7EDTJ+cxEW7AoSYmc2BXDGEIFbdlKPDuC6TlawDULPGQYD
 MgUJzQs/I8HQ9bYw5oh/Pyb7MO60CgMr414LmELwd/N7D7VUmDKqEcFyJDoe5LwAQ8v4qKGn3
 KlZZegXMjMO2H2LK1Bf8p8X2Sablcan1gliw4vYZjuYjPTuWXm0QHM37Dli/sYvd0mBNR9T3w
 UIRmwCp0wo4iqTMMdM5baXnp5T/ZD/kZLGDT81J2Ko1qs2eHcjb8+XLsrwVftQHM2Uqd52tv7
 z+IXfQMMQPcSNZM63z1/yDkUXhCLo7aSJhvDSlIraZ+/83OziGyWm1RUM/4O0rrK2UdZkkB7F
 ADJaNqUnXVVpQ30Y3BONGUyMpZda2EYUkEQwms17vXSOlkMNPiaWfcrfTkTH9kzQBCacmZ4p2
 c2r8v3ZMqzG7nGSWdT7kLgM2D3yfDLs9iWdYkoMrggQsCQWyzYdgze4H8uUJxigB28tMiJyf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284917>

Hi Andrey,

we never saw the two mails you were replying to, and please note that 1)
the preferred place to report bugs in Git for Windows is
https://github.com/git-for-windows/git/issues, as outlined in
https://git-for-windows.github.io/#contribute, and that 2) top-posting
will most likely result in less responses than you would want.

> > On 1/27/2016 2:32 PM, Andrey Chernyshov wrote:
> > >
> > > I'm using PHP storm with git for windows. Once I do a push to the github
> > > I get the following error
> > Problem signature:
> >   Problem Event Name:    APPCRASH
> >   Application Name:    git-remote-https.exe
> >   Application Version:    2.7.0.0
> >   Application Timestamp:    35316130
> >   Fault Module Name:    libidn-11.dll
> >   Fault Module Version:    0.0.0.0
> >   Fault Module Timestamp:    00170158
> >   Exception Code:    c0000005
> >   Exception Offset:    00000000000046bc
> >   OS Version:    6.3.9600.2.0.0.256.4
> >   Locale ID:    1033
> >   Additional Information 1:    a547
> >   Additional Information 2:    a54764e1ee4f5613d3fc9395100a0ff4
> >   Additional Information 3:    ac01
> >   Additional Information 4:    ac010ce737711604ec050156caebd625
> >
> > Read our privacy statement online:
> > http://go.microsoft.com/fwlink/?linkid=280262
> >
> > If the online privacy statement is not available, please read our privacy
> > statement offline:
> >   C:\windows\system32\en-US\erofflps.txt
> >
> > > If I try to push with Git GUI, it's the same, so not a PHPStorm issue...

If you can come up with a minimal, complete & verifiable example (see
http://stackoverflow.com/help/mcve), it is much more likely that I can
help you than it is right now.

My only guess is that you might be able to work around the issue by
setting the environment variable `CHARSET` to something like `cp1252`
before pushing. But that's the extent of the help I have to offer unless
the time when I have a chance to reproduce this on my computer.

Ciao,
Johannes
