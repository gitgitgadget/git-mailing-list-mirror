From: Thomas Rast <trast@inf.ethz.ch>
Subject: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 18:23:01 +0100
Message-ID: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:23:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7UR8-0002YE-TG
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 18:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236Ab3BRRXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 12:23:06 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:14835 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756033Ab3BRRXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 12:23:04 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 18:22:58 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 18 Feb 2013 18:23:00 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216485>

Hi,

Google announced the 2013 incarnation of the Google Summer of Code
program on Feb 11:

  http://www.google-melange.com/gsoc/homepage/google/gsoc2013

Git has taken part in previous years, so I figure somebody should get
the ball rolling again!  The following items need to be sorted out:

* We need an org admin.  AFAIK this was done by Peff and Shawn in
  tandem last year.  Would you do it again?

* We should prepare an "ideas page".  Last year, Peff made one on

    https://github.com/peff/git/wiki/SoC-2012-Ideas

  I couldn't edit it there over git access[1], so I made a clone in "my"
  github wiki:

    https://github.com/trast/git/wiki/SoC-2013-Ideas

  I'll volunteer to manage that wiki[2].  Please either edit it
  directly, or send me patches or pull requests.  I won't really have
  time to properly review them, but I'll do my best to merge everything.

* Naturally that ideas page is a bit stale now, and three projects
  shorter.  Please propose new ideas and refresh or delete the old ones!
  In particular some projects spawned long discussions on the list, and
  the results of those discussions should be integrated to avoid deja
  vus.

* We should have a pool of mentors and rough mentor-project matchings.
  I gathered a -- certainly incomplete -- list of previous mentors and
  students in the Cc field; maybe some of you are interested again?  If
  so, propose your own ideas and/or list yourself in the "proposed
  mentors" for some existing projects.  (I cleared all those fields for
  now.)

* Even if you don't want to mentor, you can still contribute by helping
  with discussing and ranking proposals, especially immediately before
  and after the project submission deadline (May 3).

If we want to participate again, we need to get together an org
application until *March 29* 19:00 UTC, and it won't exactly hurt to
have the ideas page settled until then too.

It would be really nice if we could do this again, I think GSoC is a
great opportunity both for Git and the involved students.

Cheers
Thomas


Footnotes: 
[1]  That's a bit silly really, since I *can* edit it via the web
interface.  Peff, perhaps you can get that fixed?

[2]  Unless Peff wants to take it over again?  You could just pull it
from the git version, it's based on your history.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
