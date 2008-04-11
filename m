From: Gabriel <g2p.code@gmail.com>
Subject: Re: [PATCH] Default to fetching a remote after adding it.
Date: Fri, 11 Apr 2008 19:46:56 +0000 (UTC)
Message-ID: <ftof7g$78v$1@ger.gmane.org>
References: <20080411203501.7095b866@localhost>
	<1207942169-2644-1-git-send-email-g2p.code@gmail.com>
	<95DDA63A-EF82-430C-B4DB-7679858E0506@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 21:48:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkPE4-0004UW-Ak
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 21:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149AbYDKTrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Apr 2008 15:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757756AbYDKTrK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 15:47:10 -0400
Received: from main.gmane.org ([80.91.229.2]:51285 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757887AbYDKTrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 15:47:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JkPDE-0002rv-5A
	for git@vger.kernel.org; Fri, 11 Apr 2008 19:47:04 +0000
Received: from pro75-5-88-162-203-35.fbx.proxad.net ([88.162.203.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 19:47:04 +0000
Received: from g2p.code by pro75-5-88-162-203-35.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 19:47:04 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pro75-5-88-162-203-35.fbx.proxad.net
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79292>

On Fri, 11 Apr 2008 21:36:27 +0200, Wincent Colaiuta wrote:

> El 11/4/2008, a las 21:29, Gabriel escribi=C3=B3:
>> This is what the user wants in 99% of cases.
>=20
> Not sure about that. I often add a remote then push, not fetch.

I didn't see that.

Well, disregard this patch, it was a bad idea to change that default.
