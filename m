From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Fri, 18 Mar 2016 08:17:37 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603180815160.4690@virtualbox>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-19-git-send-email-dturner@twopensource.com> <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com> <alpine.DEB.2.20.1603151517590.4690@virtualbox>
 <1458151880.9385.1.camel@twopensource.com> <alpine.DEB.2.20.1603161923380.4690@virtualbox> <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com> <alpine.DEB.2.20.1603171536420.4690@virtualbox>
 <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:17:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agofJ-0001CH-66
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 08:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143AbcCRHRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 03:17:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:51461 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110AbcCRHRl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 03:17:41 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lu874-1ZhfXQ2i18-011Vb1; Fri, 18 Mar 2016 08:17:38
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:vewtp/v2pEi7vvcAj5AuQAQVbIOD0X+CWaDdFGieJgSVH5q0I/l
 wNXpsCaB4TKD536sjdux4NEDolJvj+qlvCZ45fzIN+iqKhjtgBDTur/mDm+/BJJ6bZRgY1R
 Uq7JBFVHYWyg6j87K7Zz8kHBp0EYICkLYIoMFZjhdx4e6uzCm+QQCyETXlHvjVecO5GwB8O
 DCYFtGorZTqJH1LtMIp8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fTvTRQWJaQc=:Obgd9p4h+CY4P9P4AoE9HG
 bIMy9+3kislVgiuOEZVzcTGAOFb77+JObPXIUEfuhKoaYC9C9zSuCLo23GiVjoc/JtZRRyUG0
 u94yopLeWWOxuLw8mp6z3lg09h+RTQircAdyfYBoaUh8zA8qHNgL+5otRnLkX2MkvyhNojFxH
 s0M1p5pMQATlQSj+Kz52JalXi5OM5EmksAJZVS971FPqBpItDErk3Aj9dXDGOOm76u9FD7DZW
 JcsHzFtudHdaAUn+Dwt0710yCkIPCSu/Kjyua5Rw67pTYAmg167BTPc942b8KEGPwueEOQye6
 ncRF4dxQ9ClrZiiDGTybipAUOKVCI0RgqH7esBO7zxKZWwHm7/0N1LeJUOPASse066FnwRufN
 x5Um5jHZwQJ/OxmHEwOX5jUl5XYXRlS2BT9IZmPsJ+vNP0/RswRsopGbhSHfTLxJ+ZkkBj99O
 B1nZSk4gWiTDDlegUzQwNaijrAGgF2f8e0bwjv9Qk8w6uASpsYvpkY8J5WocvVKRKflfQL8Pp
 P1m35/VZ0qFpbgul/yyhGiOWAW2uTbIPS5D/xvbBBVq1tWaZKx8uUe84HAqXibNl0TDafA8Wj
 /Ut+DJWGj54vIgRJPT8OlFPuhJ97P65TteI2YInyFYxtfMYcjxNCEOojL7Yzc1xpJrWkucohY
 V7FxaXzs3N5Q6xpixkVuigTSCKTVwZT1I8V7HvptXWH4law79aLIsFjYAmAZumKZhnOrkEFrC
 MkCOec6Uz7YdqveDFMCP+Re/o1Xl5L/Eb9j5vRkYzRJ9YLEOTmnTH28+14g8J8PWDHQfv3sA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289208>

Hi Duy,

On Fri, 18 Mar 2016, Duy Nguyen wrote:

> > Well, the way I read the code it is possible that:
> >
> > 1. Git process 1 starts, reading the index
> > 2. Git process 2 starts, poking the index-helper
> > 3. The index-helper updates the .pid file (why not set a bit in the shared
> >    memory?) with a prefix "W"
> > 4. Git process 2 reads the .pid file and waits for the "W" to go away
> >    (what if index-helper is not fast enough to write the "W"?)
> > 5. Git process 1 access the index, happily oblivious that it is being
> >    updated and the data is in an inconsistent state
> 
> No, if process 1 reads the index file, then that file will remain
> consistent/unchanged all the time. index-helper is not allowed to
> touch that file at all.
> 
> The process 2 gets the index content from shm (cached by the index
> helper), verifies that it's good (with the signature at the end of the
> shm). If watchman is used, process 2 can also read the list of
> modified files from another shm, combine it with the in-core index,
> then write it down the normal way. Only then process 1 (or process 3)
> can see the new index content from the file.

So how do you deal with releasing the shared memory instances that are
essentially created for every index update?

Ciao,
Dscho
