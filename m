From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GNU patch: new 2.6 release
Date: Sun, 15 Nov 2009 14:37:55 +0100
Message-ID: <200911151437.56228.trast@student.ethz.ch>
References: <200911140109.34202.agruen@suse.de> <6672d0160911140045h70243c12w3c56ad925dc70d39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Gruenbacher <agruen@suse.de>, <git@vger.kernel.org>
To: =?utf-8?q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 14:39:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9fJs-0004YH-62
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 14:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbZKONi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 08:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbZKONi4
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 08:38:56 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:40681 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbZKONiz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 08:38:55 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 14:39:00 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 14:38:38 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <6672d0160911140045h70243c12w3c56ad925dc70d39@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132938>

Bj=C3=B6rn Gustavsson wrote:
> Do you have any plans to support git-style binary patches?
>=20
> That would be very useful in a workflow when you work in git (and hav=
e some
> binary files in the repository), but need to commit your finished wor=
k
> into another VCS (such as Clearcase).

You can simply use git-apply in this case, it also works outside a git
repository.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
