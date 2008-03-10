From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] bash: remove unnecessary conditions when checking for subcommands
Date: Mon, 10 Mar 2008 19:54:32 -0400
Message-ID: <20080310235432.GJ8410@spearce.org>
References: <1205161345-21120-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 00:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYrq0-0005zi-11
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 00:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbYCJXyk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 19:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbYCJXyk
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 19:54:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34906 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYCJXyk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 19:54:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYrp1-0006hn-82; Mon, 10 Mar 2008 19:54:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9D16120FBAE; Mon, 10 Mar 2008 19:54:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1205161345-21120-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76772>

SZEDER Gbor <szeder@ira.uka.de> wrote:
> Checking emptyness of $command is sufficient.
>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

Thanks.  I have your entire series in a branch that I will
be asking Junio to merge.

--=20
Shawn.
