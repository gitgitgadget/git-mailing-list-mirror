From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: What's in git.git (stable) and announcing GIT 1.5.0 preview
Date: Tue, 26 Dec 2006 13:22:04 +0000
Message-ID: <20061226132204.GB6558@localhost>
References: <7v3b73gx43.fsf@assigned-by-dhcp.cox.net> <emr01i$hcb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 14:22:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzCFu-00058O-HC
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 14:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWLZNV4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Dec 2006 08:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWLZNV4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 08:21:56 -0500
Received: from igraine.blacknight.ie ([81.17.252.25]:38911 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573AbWLZNVz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 08:21:55 -0500
Received: from a-103-152.cust.iol.ie ([194.125.103.152] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1GzCFR-0007cc-GS; Tue, 26 Dec 2006 13:21:41 +0000
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <emr01i$hcb$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35418>

> > =A0 =A0 =A0 gitweb: Allow search to be disabled from the config fil=
e.
>=20
> Hmmmm... IIRC this did not removed the search form. Besides it is not=
 like
> the basic search is expensive...

I just double checked.  The search feature is enabled by default, when
the feature is disable the search form isn't shown.

I don't mind if this change is reverted.

Robert
