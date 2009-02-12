From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Thu, 12 Feb 2009 22:48:35 +0100
Message-ID: <op.uo9di902a8ed4e@dellschleppa>
References: <20090205204436.GA6072@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 22:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjRh-00005F-Jp
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZBLVsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2009 16:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbZBLVsk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:48:40 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:58378 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbZBLVsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1234475315; l=541;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:Content-Transfer-Encoding:References:MIME-Version:
	Content-Type:From:Subject:To:Date:X-RZG-CLASS-ID:X-RZG-AUTH:
	DomainKey-Signature;
	bh=rOYCiAemvA8LjwPEj6d1vpUxao9l4HDJokFA9R9kbpI=;
	b=d1reettg1DlQ+uRoT094SrvKl8qX/VHkCfQXZhLR1KFdKc5ldtSrtvRNm3sEjAVFjd/
	+YPP0FURBme52RYY2UZ9tcZFsYY1R2lOBkppw/kB5enhucVcUh0GEiIPtNJ9zM5isoTEp
	fGkycydzoCDoGDqa6zfVBQrQQx1Dbr8xTnw=
DomainKey-Signature: a=rsa-sha256; s=domk; d=tilo-schwarz.de; c=nofws; q=dns;
	h=X-RZG-AUTH:X-RZG-CLASS-ID:Date:To:Subject:From:Content-Type:
	MIME-Version:References:Content-Transfer-Encoding:In-Reply-To;
	b=jDNiqR39eNwQFXa425/cK5NrJLKri5ZYU9XW7mVvLdx70C9qHH2Js/HdvqWAvKAPfK+
	TvXIHF9WQmWY11yRIM6JrG3PMI3SJIsS0t5xspCwCjBbt4zsoaWgb68msgJ7IlSxu5Rus
	cNV+9U8IXGt4xRMINnYy2JIL1zk+bvC+W7Y=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlc941cVIhg==
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CC650.dip.t-dialin.net [84.156.198.80])
	by post.strato.de (klopstock mo3) (RZmta 18.18)
	with ESMTP id g029b4l1CKTC9U for <git@vger.kernel.org>;
	Thu, 12 Feb 2009 22:48:35 +0100 (MET)
In-Reply-To: <20090205204436.GA6072@diku.dk>
User-Agent: Opera Mail/9.63 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109666>

On Thu, 05 Feb 2009 21:44:36 +0100, Jonas Fonseca <fonseca@diku.dk> wro=
te:

> Here is a much needed update fixing multiple regressions from the
> introduction of the IO API in 0.13.

Thank you for this _really_ nice program.

One thing came to my mind. When I use 'S' and then 'u' to stage/unstage=
 =20
files, it would be nice if I could press a key(maybe 'C') to fire up my=
 =20
$EDITOR, enter my commit message, let tig do the commit and find myself=
 =20
back into the updated status view. Does this sound reasonable?

Viele Gr=FC=DFe,

     Tilo
