From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 10/11] Add a TreeWalk iterator implementation for IContainer
Date: Thu, 14 Aug 2008 07:20:00 +0200
Message-ID: <200808140720.00837.robin.rosenberg.lists@dewire.com>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org> <200808132241.45402.robin.rosenberg.lists@dewire.com> <20080814041941.GA11232@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 07:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTVi1-0005TU-EF
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 07:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbYHNFsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 01:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYHNFsO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 01:48:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:9686 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbYHNFsO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 01:48:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F3A5E8006B2;
	Thu, 14 Aug 2008 07:48:12 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xc-D4dNiHHwZ; Thu, 14 Aug 2008 07:48:12 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 73595800697;
	Thu, 14 Aug 2008 07:48:12 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080814041941.GA11232@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92322>

torsdagen den 14 augusti 2008 06.19.41 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > s=C3=B6ndagen den 10 augusti 2008 10.46.25 skrev Shawn O. Pearce:
> > INCLUDE_HIDDEN is a 3.4 flag.
>=20
> Oh.  Can you amend that to be 0?
Sure.
>=20
> I'd rather not rebuild my entire branch space just for this one minor
> change so I can resend the patch.  I've got far too many large open
> branches as it is, with everything depending on everything else.  :-|
>=20

-- robin
