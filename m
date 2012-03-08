From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Unable to make git with https support
Date: Thu, 8 Mar 2012 09:19:10 +0100
Message-ID: <87eht3tsht.fsf@thomas.inf.ethz.ch>
References: <CADjGbJq_HL--_CAuE_Yj3B0srx=WDficot8bgadvW92zz9PJdg@mail.gmail.com>
	<87pqcotc9w.fsf@thomas.inf.ethz.ch>
	<CADjGbJpL69BTpOHyToqYmSWSBYA--6fSGB4CZyBXvdA9Zy4NvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Nate Parsons <parsons.nate@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 09:19:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5YZC-0000uB-3P
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 09:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968Ab2CHITN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 03:19:13 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:9151 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048Ab2CHITM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 03:19:12 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 09:19:10 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 09:19:10 +0100
In-Reply-To: <CADjGbJpL69BTpOHyToqYmSWSBYA--6fSGB4CZyBXvdA9Zy4NvQ@mail.gmail.com>
	(Nate Parsons's message of "Wed, 7 Mar 2012 17:30:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192536>

Nate Parsons <parsons.nate@gmail.com> writes:

> On Wed, Mar 7, 2012 at 2:57 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Have you also installed libcurl-devel (or whatever the package might be
>> called, but it seems you are also using opensuse)?
>
> This is the problem, thanks. I only have curl and libcurl4 installed,
> and I was hoping to not install any new packages.

Which is to say, you either have a totally crazy aversion against
installing (headers-only, no less) packages, or you have a hidden reason
why you don't want to do that and you're not telling us.

Meh.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
