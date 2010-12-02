From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Thu, 2 Dec 2010 09:53:24 +0100
Message-ID: <20101202095324.34237fb2@jk.gs>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino>
	<87r5e1v2g8.fsf@picasso.cante.net>
	<7vzkspuw8g.fsf@alter.siamese.dyndns.org>
	<295D1E95-1C61-4960-8C9C-BDB0BD4A1A50@sb.org>
	<87mxopt8my.fsf@picasso.cante.net>
	<E02740CE-37EE-4701-BB2D-18AD493D1C05@sb.org>
	<87aakpt7uw.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 09:54:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO4vf-00035N-1p
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 09:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab0LBIx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 03:53:29 -0500
Received: from zoidberg.org ([88.198.6.61]:50938 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab0LBIx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 03:53:28 -0500
Received: from jk.gs (p508A3604.dip.t-dialin.net [::ffff:80.138.54.4])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 02 Dec 2010 09:53:26 +0100
  id 0040044D.4CF75E86.00000821
In-Reply-To: <87aakpt7uw.fsf@picasso.cante.net>
X-Mailer: Claws Mail 3.7.7 (GTK+ 2.22.0; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162685>

[Cc un-culled]

--- Jari Aalto <jari.aalto@cante.net> wrote:

> The reader have to guess "imagined groups"? Hm, that's interesting.

Perhaps a more desirable (and agreeable) patch would introduce group
subheadings, then? I agree with the majority of people who chimed in
here that functional grouping is a good thing. Perhaps we should
actually commit to that by having explicit groups.

In rev-list-related options we already have a couple of explicit
groups. I think I'd go insane if I ever had to find anything in there
without those groups.

> [...] Git's command
> line is inconsistent in many places and there is room for improvement.
> Documentation is one way to spot those.

That seems to be the only reason you've brought forward for alphabetic
sorting, except the claim that "people read from top to
bottom" (which is essentially true, but I don't think anybody would
read, say, a printed dictionary all the way through; the alphabetic
ordering there is for being able to index/search the content in the
absence of another way to index/search).

In any case, the end user will probably be more often interested in
appropriately grouped options than in being able to easily find
inconsistencies between various commands.

-Jan
