From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GSoC Application [ Parallelism + Git.pm ]
Date: Wed, 21 Mar 2012 13:47:26 +0100
Message-ID: <871uomt929.fsf@thomas.inf.ethz.ch>
References: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 13:47:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAKwx-0007Pg-4C
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 13:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758137Ab2CUMra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 08:47:30 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:11402 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757328Ab2CUMr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 08:47:29 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 13:47:27 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 13:47:27 +0100
In-Reply-To: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com>
	(Subho Banerjee's message of "Sun, 18 Mar 2012 13:06:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193575>

Subho Banerjee <subs.zero@gmail.com> writes:

> * In the first one, which wants to parallelize certain commands in
> git, I believe  the major challenges will be to actually find a large
> list of commands which can be parallelized.In addition to the commands
> mentioned in the Ideas page, only other place I currently think of
> exploiting parallelism is in traversing the commit tree when one is
> cloning a repository. I would really like it if someone can suggest
> more places where this sort of parallelism might be usable, so that I
> could use that to make a more complete application. I believe one of
> the major difficulties I will initially face, is my unfamiliarity with
> the code. This makes finding these commands which might have better
> performance with parallelism a little difficult.

Please read my reply to Felipe in the other thread:

  http://thread.gmane.org/gmane.comp.version-control.git/193352/focus=193574

as I'd have to repeat myself.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
