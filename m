From: pinard@iro.umontreal.ca (=?utf-8?Q?Fran=C3=A7ois?= Pinard)
Subject: Re: git log --pretty=format:%ai (documentation bug?)
Date: Mon, 04 Feb 2008 18:41:36 -0500
Organization: Linux Private Site
Message-ID: <ygewspk9tn3.fsf@phenix.progiciels-bpi.ca>
References: <ygelk60o500.fsf@phenix.progiciels-bpi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 00:42:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMAxA-0002gi-Rm
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 00:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212AbYBDXlr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 18:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756180AbYBDXlr
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 18:41:47 -0500
Received: from main.gmane.org ([80.91.229.2]:56968 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756024AbYBDXlr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 18:41:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JMAwZ-0006eD-9a
	for git@vger.kernel.org; Mon, 04 Feb 2008 23:41:43 +0000
Received: from 206-248-137-202.dsl.teksavvy.com ([206.248.137.202])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 23:41:43 +0000
Received: from pinard by 206-248-137-202.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 23:41:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 206-248-137-202.dsl.teksavvy.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:4ixtnjahba8OIw5tOJi3E6xmuFU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72591>

pinard@iro.umontreal.ca (Fran=C3=A7ois Pinard) writes:

> I just noticed that '%ai' and '%ci' are accepted formats for "git log=
"
> (nice! -- git dates should be ISO 8601 all over by default!), yet the
> man page does not document them.

Sorry for my noise.  These *are* documented.  It is just than git man
pages are not installed by default :-).

--=20
=46ran=C3=A7ois Pinard   http://pinard.progiciels-bpi.ca
