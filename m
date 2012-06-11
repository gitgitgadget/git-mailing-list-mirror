From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: [PATCH]Test environment for git-remote-mediawiki
Date: Mon, 11 Jun 2012 22:27:52 +0200
Message-ID: <4FD654C8.6040208@ensimag.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	charles.roussel@ensimag.imag.fr,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Simon PERRAT <Simon.Perrat@ensimag.imag.fr>,
	Julien Khayat <khayatj@ensimag.imag.fr>,
	Junio C Hamano <gitster@pobox.com>, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 22:28:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeBDX-0004Ag-W4
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 22:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab2FKU17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 16:27:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60927 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab2FKU17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 16:27:59 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5BKIwDJ024372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 22:18:58 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q5BKRpLF022253;
	Mon, 11 Jun 2012 22:27:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jun 2012 22:18:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BKIwDJ024372
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1340050738.31283@92tF2VYeBSdlx6KtsA08/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199718>

Good evening.

We have finally took into into account all existing advices about our=20
contribution to git-mediawiki.
We are proposing, in the following of this mail, our work for the test=20
environment of git-mediawiki.

We would like to propose you this work for git-remote-mediawiki, becaus=
e=20
we believe that, this fonctionnality needs a suitable test environment=20
if we intend to upgrade it in the future.

We would like to have some piece of advice for improving it. We will be=
=20
glad to be accepted as a viable contribution for git-remote-mediawiki :=
).

Have a nice evening.

Simon C.

--=20
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
