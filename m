From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Idea for git-touch
Date: Thu, 12 Nov 2009 18:01:32 +0100
Message-ID: <20091112180132.5819f963@perceptron>
References: <4AFC348B.4000202@ualg.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?THXDrXM=?= Sousa <llsousa@ualg.pt>
X-From: git-owner@vger.kernel.org Thu Nov 12 18:01:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8d3G-0004Jq-II
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 18:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbZKLRBa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 12:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbZKLRBa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 12:01:30 -0500
Received: from zoidberg.org ([88.198.6.61]:57981 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477AbZKLRB3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 12:01:29 -0500
Received: from perceptron (xdsl-78-35-170-176.netcologne.de [::ffff:78.35.170.176])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 12 Nov 2009 18:01:33 +0100
  id 004D021B.4AFC3F6D.00004083
In-Reply-To: <4AFC348B.4000202@ualg.pt>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132783>

Hi Lu=C3=ADs,

> [...] Then I do a git-reset HEAD~1, git-add . and git-commit with
> the same message to have the current date.

There is an existing command that does pretty much exactly that:
git commit --amend.

Jan
