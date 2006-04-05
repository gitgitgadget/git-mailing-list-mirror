From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 5 Apr 2006 15:35:44 +0200 (CEST)
Message-ID: <20060405133544.69578.qmail@web25802.mail.ukl.yahoo.com>
References: <Pine.LNX.4.64.0604050906590.2550@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 15:35:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR8Ap-0004Bt-WB
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 15:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWDENfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Apr 2006 09:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWDENfr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 09:35:47 -0400
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:24940 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751141AbWDENfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 09:35:46 -0400
Received: (qmail 69580 invoked by uid 60001); 5 Apr 2006 13:35:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jSZJmCb+URtnXSEk39gAfMlOnRiZf/iv0qNipi/Y+OaDipY1xgCp6eJO464sAxp/rCNUGnfsAI9q2+SnX6soUQ/EnPjxyuhy2hVo1ymeRcByIuZW5v/q1Y/jJ+cs/N92AgYZdbr+ak/10IPw3sacVPdYQ/uoG9VAFK9fkYVf8Uo=  ;
Received: from [194.3.162.233] by web25802.mail.ukl.yahoo.com via HTTP; Wed, 05 Apr 2006 15:35:44 CEST
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604050906590.2550@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18432>


--- Nicolas Pitre <nico@cam.org> a =E9crit :

> On Wed, 5 Apr 2006, moreau francis wrote:
> >=20
> > well maybe it's just stupid, but why not simply transforming binary=
 files
> into
> > ascii files (maybe by using uuencode) before  using git-diff-* brot=
hers and
> > git-apply ?
>=20
> Imagine if the only difference between two versions of the same file =
is=20
> a single byte inserted at the very beginning.  The uuencode would the=
n=20
> be totally different between the two files.
>=20

ok uuencode was just a bad example for encoding...

=46rancis



=09

=09
	=09
_______________________________________________________________________=
____=20
Nouveau : t=E9l=E9phonez moins cher avec Yahoo! Messenger ! D=E9couvez =
les tarifs exceptionnels pour appeler la France et l'international.
T=E9l=E9chargez sur http://fr.messenger.yahoo.com
