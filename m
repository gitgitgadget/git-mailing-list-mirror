From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: Idea for git-touch
Date: Thu, 12 Nov 2009 18:08:41 +0100
Message-ID: <20091112180841.001ae651@perceptron>
References: <4AFC348B.4000202@ualg.pt>
	<20091112180132.5819f963@perceptron>
	<4AFC4051.5030607@ualg.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?THXDrXM=?= Sousa <llsousa@ualg.pt>
X-From: git-owner@vger.kernel.org Thu Nov 12 18:08:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8dAB-0008Ar-33
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 18:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZKLRIk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 12:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZKLRIk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 12:08:40 -0500
Received: from zoidberg.org ([88.198.6.61]:37830 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbZKLRIj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 12:08:39 -0500
Received: from perceptron (xdsl-78-35-170-176.netcologne.de [::ffff:78.35.170.176])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 12 Nov 2009 18:08:42 +0100
  id 004D021B.4AFC411B.00004B14
In-Reply-To: <4AFC4051.5030607@ualg.pt>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132786>

On Thu, 12 Nov 2009 17:05:21 +0000, Lu=C3=ADs Sousa <llsousa@ualg.pt> w=
rote:
> But still preserves the original date, isn't it?

Yes, and I just remembered that, too. Sorry. Today is not my day.

Even so, you can still save one command:

  git reset --soft HEAD^
  git commit

Jan
