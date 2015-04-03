From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [PATCH] clone: Warn if clone lacks LICENSE or COPYING file
Date: Fri, 03 Apr 2015 17:18:33 -0400 (EDT)
Message-ID: <E1Ye8z3-000617-SW@rmm6prod02.runbox.com>
References: <CACBZZX67igE67+y7Tme=_OC7JiT726qB4X18+8Mvg1ewssQ_ug@mail.gmail.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:18:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye8zA-0002lo-3D
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458AbbDCVSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 17:18:36 -0400
Received: from aibo.runbox.com ([91.220.196.211]:33036 "EHLO aibo.runbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbbDCVSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 17:18:35 -0400
Received: from [10.9.9.241] (helo=rmm6prod02.runbox.com)
	by bars.runbox.com with esmtp (Exim 4.71)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1Ye8z3-0002yX-FV
	for git@vger.kernel.org; Fri, 03 Apr 2015 23:18:33 +0200
Received: from mail by rmm6prod02.runbox.com with local (Exim 4.76)
	(envelope-from <dwheeler@dwheeler.com>)
	id 1Ye8z3-000617-SW
	for git@vger.kernel.org; Fri, 03 Apr 2015 23:18:33 +0200
Content-Disposition: inline
Received: from [Authenticated user (258406)] by secure.runbox.com with
 http (RMM6); for <git@vger.kernel.org>; Fri, 03 Apr 2015 21:18:33 GMT
X-Mailer: RMM6
In-Reply-To: <CACBZZX67igE67+y7Tme=_OC7JiT726qB4X18+8Mvg1ewssQ_ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266729>

On Sun, 22 Mar 2015 18:56:52 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son <avarab@gmail.com> wrote:
> However perhaps an interesting generalization of this would be
> something like a post-clone hook, obviously you couldn't store that i=
n
> .git/hooks/ like other githooks(5) since there's no repo yet, but
> having it configured via the user/system config might be an
> interesting feature.

Would that be acceptable to the wider group?

--- David A. Wheeler
