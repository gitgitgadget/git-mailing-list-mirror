From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Master branch not updating
Date: Mon, 22 Mar 2010 17:47:49 +0100
Message-ID: <201003221747.50504.trast@student.ethz.ch>
References: <295c22191003220943o2ef330ddk58a8180411ddbb2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Jacopo Pecci <jacopo.pecci@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 17:48:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtknH-0005kl-8u
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab0CVQrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 12:47:53 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:38142 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532Ab0CVQrx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 12:47:53 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Mar
 2010 17:47:52 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Mar
 2010 17:47:51 +0100
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.1; x86_64; ; )
In-Reply-To: <295c22191003220943o2ef330ddk58a8180411ddbb2b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142946>

Jacopo Pecci wrote:
> Hi,
> I have a simple local project, with only the master branch. After few
> commits with Git Extensions, I have realized the label [master] was
> stuck, it was not pointing at the latest commit any more. Nevertheles=
s
> I could see a full list of all my new commits with the proper comment=
s
> in the main window.  It looked like I was not on any branch (if this
> is possible)
> Then I have tried =E2=80=9Ccheckout master branch=E2=80=9D, suddenly =
all the commits
> in between the one labelled [master] and the latest one vanished. I
> have not been able to get back.
>=20
> I am terribly afraid I have lost 4 day work. Do you have any
> suggestion? How is it possible that something which I have committed
> is not retrievable anymore.

Read this very nice article by Sitaram Chamarty:

http://sitaramc.github.com/concepts/detached-head.html

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
