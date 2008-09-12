From: Petr Baudis <pasky@suse.cz>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 21:13:36 +0200
Message-ID: <20080912191336.GD10360@machine.or.cz>
References: <19449377.post@talk.nabble.com> <200809121754.30277.jnareb@gmail.com> <20080912160538.GB10360@machine.or.cz> <200809121940.43471.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 21:14:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeE6R-0007kn-A5
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 21:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbYILTNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Sep 2008 15:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbYILTNi
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 15:13:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51349 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981AbYILTNi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 15:13:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1AE39393A36E; Fri, 12 Sep 2008 21:13:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809121940.43471.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95760>

On Fri, Sep 12, 2008 at 07:40:43PM +0200, Jakub Narebski wrote:
> Dnia pi=B1tek 12. wrze=B6nia 2008 18:05, Petr Baudis napisa=B3:
> > On Fri, Sep 12, 2008 at 05:54:29PM +0200, Jakub Narebski wrote:
> >>
> >> P.S. Could you please gather some statistics to compare the period
> >> before and after installing "smart" HTTP server (and after smart
> >> clients became widespread).
> >=20
> > What kind of statistics?
>=20
> In the simplest case just some averaged system load (perhaps load=20
> average from uptime, or from top, or from /proc) before and after.
> Perhaps bandwidth used per week or something like that too.

This statistics are already available at

	http://rover.dkm.cz/~yanek/stats/

> If you have time and interest, CPU load, disk IO, network IO or
> network bandwidth used, and average time to serve request (latency)
> for fetching via HTTP protocol, for "dumb" and "smart" clients,
> perhaps averaged over number of requests.  (I don't know unfortunatel=
y=20
> how to get such data).
>=20
> In short: check how "smart" HTTP protocol would improve things.

=2E..and I don't know out of the top of my head how to best gather the
rest either. ;-) (If someone is really interested about all this, that'=
s
fine, but they have to give me a pre-made cookbook of recipes how to
hook that up to RRD.)

--=20
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
