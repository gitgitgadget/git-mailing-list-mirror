From: =?utf-8?Q?=C5=81ukasz?= Stelmach <lukasz.stelmach@iem.pw.edu.pl>
Subject: How to log a host (or a repository) of a commit?
Date: Thu, 01 Apr 2010 20:18:29 +0200
Message-ID: <87fx3fniiy.fsf@dasa3.iem.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 01 20:18:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxOyX-0003BF-Is
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 20:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab0DASSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 14:18:37 -0400
Received: from lo.gmane.org ([80.91.229.12]:41358 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab0DASSg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 14:18:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NxOyR-00038y-1P
	for git@vger.kernel.org; Thu, 01 Apr 2010 20:18:35 +0200
Received: from dasa3.iem.pw.edu.pl ([194.29.147.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 20:18:35 +0200
Received: from lukasz.stelmach by dasa3.iem.pw.edu.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 20:18:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dasa3.iem.pw.edu.pl
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:3YfOoiGuSNaOJWYSd8kDjHN0qDo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143739>

Hi.

Is there a way of logging (an retrieveing this information) where a
commit has been created and keeping it when merging/pulling/pushing? Fo=
r
me It may be either a host or a repository.  The host would be slightly
better as I have some repositories on flash drives.

--=20
Best regards
=C5=81ukasz Stelmach
