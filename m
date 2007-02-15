From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] GIT 1.5.0
Date: Wed, 14 Feb 2007 21:11:13 -0500
Message-ID: <20070215021113.GA29732@spearce.org>
References: <7vlkj1v3av.fsf@assigned-by-dhcp.cox.net> <er0eee$6qp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 03:11:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHW5y-0006xp-63
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 03:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbXBOCLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Feb 2007 21:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbXBOCLT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 21:11:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56802 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964832AbXBOCLR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Feb 2007 21:11:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHW5Q-0002Pt-Fw; Wed, 14 Feb 2007 21:11:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D588E20FBAE; Wed, 14 Feb 2007 21:11:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <er0eee$6qp$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39788>

Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
>=20
> > =A0- git-blame learned a new option, --incremental, that tells it
> > =A0 =A0to output the blames as they are assigned. =A0A sample scrip=
t
> > =A0 =A0to use it is also included as contrib/blameview.
>=20
> And there are example GUI blameview (Perk GTK2), and example Emacs mo=
dule
> for incremental git-blame, both in contib/ area.=20

Not to mention the incremental blame viewer built into git-gui:

	git gui blame HEAD foo.c

--=20
Shawn.
