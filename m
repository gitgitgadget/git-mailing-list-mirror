From: =?utf-8?B?0KLQuNGF0L7QvSDQotCw0YDQvdCw0LLRgdC60LjQuQ==?= 
	<t.t@unixforum.org>
Subject: Re: how to delete from history some files, and commits with them?
Date: Wed, 14 Jul 2010 19:58:31 +0300
Message-ID: <20100714165830.GA13717@Nokia-N810-43-7>
References: <loom.20100714T170722-272@post.gmane.org> <20100714161508.GA2330@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 19:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5Rv-0004Od-1m
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928Ab0GNRIk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 13:08:40 -0400
Received: from mail.mezon.ru ([88.212.197.163]:52797 "EHLO mail.mezon.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab0GNRIk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:08:40 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jul 2010 13:08:40 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.mezon.ru (Postfix) with ESMTP id 7D6984B8618;
	Wed, 14 Jul 2010 20:58:32 +0400 (MSD)
X-Spam-Flag: SKIP
X-Spam-Yversion: Spamooborona-2.3
Received: from ? (lifeboatness.extreme.volia.net [93.74.14.197])
	by mail.mezon.ru (Postfix) with ESMTP id D4C244B807B;
	Wed, 14 Jul 2010 20:58:31 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <20100714161508.GA2330@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151014>

On Wed, 14.07.2010 11:15:08 , Jonathan Nieder wrote:
> Tikhon Tarnavski wrote:
>=20
> >               I can create two clones
> > and run filter-branch in both to delete
> > files. But I can't find how I may
> > delete empty commits after that.
>=20
> Maybe --prune-empty can help.

I was forced to use git 1.5.6 (by technical reasons) where this option =
is
not available (and I didn't know about it). Now I can switch to 1.7 so =
I'll
try it soon. Thank you very much.

--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=A2=D0=B8=D1=85=D0=BE=D0=BD =D0=A2=D0=B0=D1=80=D0=BD=D0=B0=D0=B2=D1=81=
=D0=BA=D0=B8=D0=B9.
