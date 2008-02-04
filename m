From: pinard@iro.umontreal.ca (=?utf-8?Q?Fran=C3=A7ois?= Pinard)
Subject: git log --pretty=format:%ai (documentation bug?)
Date: Mon, 04 Feb 2008 15:12:31 -0500
Organization: Linux Private Site
Message-ID: <ygelk60o500.fsf@phenix.progiciels-bpi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 21:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM87O-0000Y8-He
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481AbYBDUkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 15:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756328AbYBDUkH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:40:07 -0500
Received: from main.gmane.org ([80.91.229.2]:38542 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755501AbYBDUkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 15:40:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JM86k-0007Cb-F2
	for git@vger.kernel.org; Mon, 04 Feb 2008 20:40:02 +0000
Received: from 206-248-137-202.dsl.teksavvy.com ([206.248.137.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 20:40:02 +0000
Received: from pinard by 206-248-137-202.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 20:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 206-248-137-202.dsl.teksavvy.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:XuKpxv8zOS6RJBnF2BpjtrD38dk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72560>

Hi, git people.

I just noticed that '%ai' and '%ci' are accepted formats for "git log"
(nice! -- git dates should be ISO 8601 all over by default!), yet the
man page does not document them.

Of course, I would prefer to see these documented than removed! :-)

--=20
=46ran=C3=A7ois Pinard   http://pinard.progiciels-bpi.ca
