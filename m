From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git bisect problems/ideas
Date: Mon, 17 Jan 2011 14:38:44 +0100
Message-ID: <20110117133843.GA23625@neumann>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
	<AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
	<20110117115133.GA29207@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	"Aaron S. Meurer" <asmeurer@gmail.com>, <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 17 14:44:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PepNb-0003Rz-N9
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 14:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab1AQNoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 08:44:14 -0500
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:13750 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab1AQNoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 08:44:13 -0500
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2011 08:44:13 EST
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 17 Jan
 2011 14:38:42 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 17 Jan
 2011 14:38:44 +0100
Content-Disposition: inline
In-Reply-To: <20110117115133.GA29207@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165173>


On Mon, Jan 17, 2011 at 05:51:33AM -0600, Jonathan Nieder wrote:
> Christian Couder wrote:
>=20
> > Yeah, many people find it difficult to reverse the meaning of "bad"
> > and "good" when looking for a fix. There were some suggestions at s=
ome
> > points to do something about it. Some of the suggestions were to us=
e
> > some aliases for "good" and "bad", but there was no agreement. Othe=
r
> > suggestions had a patch attached but the patch was not good enough =
or
> > something.
>=20
> Any pointers to such a discussion or patch?  Maybe whatever small
> detail caused it to be forgotten could be fixed...

http://thread.gmane.org/gmane.comp.version-control.git/86063


Best,
G=E1bor
