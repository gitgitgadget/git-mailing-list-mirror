From: Mark Struberg <struberg@yahoo.de>
Subject: Re: German translation of git man pages
Date: Wed, 30 Jul 2008 11:21:12 +0000 (GMT)
Message-ID: <969890.11742.qm@web27801.mail.ukl.yahoo.com>
References: <20080730110602.GB20957@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fabio Scotoni <fabio@esse.ch>,
	"Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 30 13:29:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO9rU-0004s1-6O
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 13:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbYG3L14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2008 07:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbYG3L14
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 07:27:56 -0400
Received: from web27801.mail.ukl.yahoo.com ([217.146.182.6]:36864 "HELO
	web27801.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753601AbYG3L1z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 07:27:55 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jul 2008 07:27:55 EDT
Received: (qmail 12249 invoked by uid 60001); 30 Jul 2008 11:21:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=nLexw+kC6TPkjeEgk/EHF5PO8+1+3mcS4reZAmoKArBKZrcOIAIUuCI1bCRKSwXNh9fbg0Z/Q9XEL41gx0yrquT9zYyiZFdswekWR2/BnM9tgLU7IyNbz07Hz9bfCHCz36uG+R7rm95bxs+51RnvXctQPDayCeT5q5vlBvPvWkA=;
Received: from [81.19.198.7] by web27801.mail.ukl.yahoo.com via HTTP; Wed, 30 Jul 2008 11:21:12 GMT
X-Mailer: YahooMailWebService/0.7.218
In-Reply-To: <20080730110602.GB20957@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90764>


My personal opinion:
don't translate termini technici in technical documentations, but add a=
 translated explanation of each in the preamble.

I've never read any german book or comment where e.g. 'a commit' has be=
en translated to 'das Uebergebene'...=20
(Reminds me of some old Siemens BS2000 mainfraims back in the 80s. They=
 translated really ALL terms to german, which was frankly completely un=
readable)

LieGr=FC,
strub

--- Stephen R. van den Berg <srb@cuci.nl> schrieb am Mi, 30.7.2008:

> Von: Stephen R. van den Berg <srb@cuci.nl>
> Betreff: Re: German translation of git man pages
> An: "Fabio Scotoni" <fabio@esse.ch>
> CC: git@vger.kernel.org
> Datum: Mittwoch, 30. Juli 2008, 13:06
> Fabio Scotoni wrote:
> >Our native language is german and they don't like
> to read english
> >documentation. I already started translating but have
> some problems:
> >Should i translate "branch" with the
> appropriate german word or keep it
> >english? This is a Problem for "pull"
> "push" and the other actions as
> >well. Basically it's possible to copy words, but
> that isn't very
> >esthetical.
>=20
> A good translation will translate those words.  However,
> since the
> commandline interface uses the English words, you'll be
> forced to
> re-explain that relationship a lot of times (using
> parenthesis, most
> likely).


      __________________________________________________________
Gesendet von Yahoo! Mail.
Dem pfiffigeren Posteingang.
http://de.overview.mail.yahoo.com
