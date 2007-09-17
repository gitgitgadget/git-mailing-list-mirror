From: Christian Stimming <stimming@tuhh.de>
Subject: Re: RFC: German translation vocabulary
Date: Mon, 17 Sep 2007 21:09:17 +0200
Message-ID: <200709172109.18539.stimming@tuhh.de>
References: <200709161438.37733.stimming@tuhh.de> <20070917075433.GF17021@cip.informatik.uni-erlangen.de> <Pine.LNX.4.64.0709171013230.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alexander Wuerstlein <snalwuer@cip.informatik.uni-erlangen.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXM5D-0000GW-FT
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 21:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbXIQTPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 15:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757437AbXIQTPr
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 15:15:47 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:56083 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757396AbXIQTPq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 15:15:46 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l8HJFEro002653
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 17 Sep 2007 21:15:14 +0200
Received: from [192.168.2.102] (p54901244.dip0.t-ipconnect.de [84.144.18.68])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l8HJFAFv022603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2007 21:15:14 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0709171013230.28586@racer.site>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58469>

Am Montag, 17. September 2007 11:17 schrieb Johannes Schindelin:
> > > >> msgid "commit [noun]"
> > > >> msgstr "?bertragung (Sendung?, ?bergabe?, Einspielung?,
> > > >> Ablagevorgang?)"
> > > >
> > > > "Vorgang"? (think Beamtendeutsch)
> > >
> > > Buchung, Einbuchung, Verbuchung, Registrierung?
> >
> > Transaktion?
>
> The real problem is that we use "commit" in two senses:
>
> - the action ("to commit", but also, "to do a commit") of making a new
>   revision, but also
>
> - the revision in the revision graph ("is this in the commit abcdef?").

This is exactly the noun vs. the verb ambiguity. This is exactly why those are 
mentioned as two different entries in the glossary.

> So I do not think that any proposals reflect the ambiguity of "a commit".
> I actually talk about "Revision" in German, when I refer to a commit.

Yes, that's what I am leaning towards as well. Let's see.

Christian
