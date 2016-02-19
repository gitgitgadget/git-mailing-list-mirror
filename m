From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Fri, 19 Feb 2016 08:17:19 +0100
Message-ID: <vpq60xl88zk.fsf@anie.imag.fr>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<CACsJy8D-bHOLGKq0ZELcPYWpKXgct3HBF9Btp3UPw+tqGUR5Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:17:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWfJo-000613-V9
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 08:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226AbcBSHR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 02:17:29 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54152 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbcBSHR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 02:17:28 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1J7HJrR003264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 19 Feb 2016 08:17:19 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1J7HJYH030950;
	Fri, 19 Feb 2016 08:17:19 +0100
In-Reply-To: <CACsJy8D-bHOLGKq0ZELcPYWpKXgct3HBF9Btp3UPw+tqGUR5Bw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 19 Feb 2016 10:09:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 19 Feb 2016 08:17:19 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1J7HJrR003264
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456471040.91145@2b7rygrCHDCf3gd/QXa/5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286661>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 18, 2016 at 1:58 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Feel free to start writting an idea for
>> http://git.github.io/SoC-2016-Ideas/. It'd be nice to have a few more
>> ideas before Friday. We can polish them later if needed.
>
> Probably too late now, anyway..

It's still time. I'll post the application very soon (a few hours from
now), but the idea list is not included in the application, but linked
from it. So we can add something before reviewers follow the link, and
obviously we can add more before students start picking them.

> with David's multiple ref backend work, we could have a third,
> no-dependency backend. We can use index format to store refs.

This sounds like an interesting but ambitious project for a GSoC. There
are a lot of new stuff to understand for someone potentially new to
Git's codebase. And it's hard to work incrementally: the result would
hardly be mergeable before being almost finished.

I think it's interesting to offer the idea, but there should be a
warning for the student about the difficulties.

Would you be willing to (co-)mentor?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
