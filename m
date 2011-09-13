From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>
Subject: Re: [PATCH/RFC] bash: add --word-diff option to diff auto-completion
Date: Wed, 14 Sep 2011 01:37:12 +0200
Message-ID: <20110913233712.GE2078@goldbirke>
References: <4E6F720A.3020103@yahoo.com.br> <20110913165847.GB11076@elie>
	<4E6FA541.7000100@yahoo.com.br> <20110913191448.GC14917@elie>
	<20110913232941.GC2078@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rodrigo Rosenfeld Rosas <lbocseg@yahoo.com.br>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 01:37:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3cXb-00017P-7z
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 01:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091Ab1IMXhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Sep 2011 19:37:15 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:52185 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933078Ab1IMXhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 19:37:14 -0400
Received: from localhost6.localdomain6 (p5B130EED.dip0.t-ipconnect.de [91.19.14.237])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lurkf-1RBu6w24SP-00zzdU; Wed, 14 Sep 2011 01:37:11 +0200
Content-Disposition: inline
In-Reply-To: <20110913232941.GC2078@goldbirke>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:HRjRUisyMW6jP7SLzd8NPCtyUcUD4jMdFRU8MBbC7N3
 JHNxko87hWU4qbIBLPV/wTzrYMyrolNpe3AT1/cHV+QUPy6o24
 NVwCAb9AzpQz97f9OE45UsJONE96RwJQ0XK3wv2i86JuJaqr/y
 KBq3aq7YEmYJ4jPPiIXC45J8IvoNwJbjWSxxJepxKc/cRwZSSh
 40UJG4Ke0ZGjU3BLJ6aA9+z62LbtAbCFpsdgCyFW4Vbvmq7yZ9
 I3iE8cPaqhZzj7JDG0ybYrQGKAGiJH2zW3PHOHPhtbxymACSZt
 SKgqEls/0ZbXYPzknIvrkqEe5LA2hOi8z9pvsw/e4grtJ6VhsO
 AqD1CJXPGQpEFhsrKrHs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181327>

On Wed, Sep 14, 2011 at 01:29:41AM +0200, SZEDER G=E1bor wrote:
> Or is it just too late here and I'm missing something
> obvious?
>=20
> Completing the mode for --word-diff=3D<TAB> is a good idea, but c'mon=
,
> there are plenty of examples ;)  Have a look at _git_am(),
> _git_format_patch(), or _git_init() for something easy, and
> _git_commit(), _git_log(), or _git_notes() for something fancy.
>=20
> Note that --word-diff=3D is also valid for log and shortlog, so the s=
ame
> can be done there, too.

Not shortlog, show.  It's definitely too late... ;)
