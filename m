From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: German translation vocabulary
Date: Mon, 17 Sep 2007 10:17:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171013230.28586@racer.site>
References: <200709161438.37733.stimming@tuhh.de>
 <20070916172341.GA17021@cip.informatik.uni-erlangen.de> <851wcy47n4.fsf@lola.goethe.zz>
 <20070917075433.GF17021@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Alexander Wuerstlein <snalwuer@cip.informatik.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:18:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCkp-0000Vj-0i
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbXIQJSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbXIQJSo
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:18:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:49230 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752979AbXIQJSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:18:43 -0400
Received: (qmail invoked by alias); 17 Sep 2007 09:18:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 17 Sep 2007 11:18:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19j4g0VxPFjruE5bqHHqsNd8S3fbThbrTbKS79ugt
	rYBo3ZFfEnurRr
X-X-Sender: gene099@racer.site
In-Reply-To: <20070917075433.GF17021@cip.informatik.uni-erlangen.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58407>

Hi,

On Mon, 17 Sep 2007, Alexander Wuerstlein wrote:

> On 070916 23:34, David Kastrup <dak@gnu.org> wrote:
> > Alexander Wuerstlein <snalwuer@cip.informatik.uni-erlangen.de> writes:
> > 
> > > On 070916 14:46, Christian Stimming <stimming@tuhh.de> wrote:
> > >> msgid "commit [noun]"
> > >> msgstr "?bertragung (Sendung?, ?bergabe?, Einspielung?, Ablagevorgang?)"
> > >
> > > "Vorgang"? (think Beamtendeutsch)
> > 
> > Buchung, Einbuchung, Verbuchung, Registrierung?
> 
> Transaktion?

The real problem is that we use "commit" in two senses:

- the action ("to commit", but also, "to do a commit") of making a new 
  revision, but also

- the revision in the revision graph ("is this in the commit abcdef?").

So I do not think that any proposals reflect the ambiguity of "a commit".
I actually talk about "Revision" in German, when I refer to a commit.

Ciao,
Dscho
