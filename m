From: "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr>
Subject: [Git-MediaWiki] Test environment for Git-MediaWiki
Date: Tue, 05 Jun 2012 15:20:37 +0200
Message-ID: <4FCE07A5.9020001@ensimag.imag.fr>
Reply-To: Simon.Cathebras@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	julien.khayat@ensimag.imag.fr,
	Simon PERRAT <Simon.Perrat@ensimag.imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>,
	Charles Roussel <charles.roussel@ensimag.fr>, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 15:21:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbtgr-0000Kb-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 15:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934133Ab2FENUt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 09:20:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59703 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564Ab2FENUt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 09:20:49 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q55DBtg0002826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2012 15:11:55 +0200
Received: from [IPv6:::1] (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q55DKbFM026990;
	Tue, 5 Jun 2012 15:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Jun 2012 15:11:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q55DBtg0002826
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339506717.59179@SMRCHYbjUVrmbDERI9OwhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199238>

Good afternoon,

This test environment is created to test the previously implemented=20
git-remote-mediawiki, which was developped last year.
We created in this environment some functions to manipulate a MediaWiki=
=2E=20
This way, it will be easier to build some tests for the Git-MediaWiki=20
contribution.

This is our third version for this test environment. We have removed=20
several errors in our code since the V1. Plus, we added some tests usin=
g=20
our environment. We are now presenting our code for an inclusion into=20
the P.U branch.

If you want to test our code, please have a look in this wiki :=20
https://github.com/Fafinou/git/wiki .
And follow the instructions.

If you have any correction(s) proposal, please let us know, and we will=
=20
fix them as soon as possible.
Thank you in advance for your attention ;).

Have a nice day.

Simon C, for the Team

--
CATHEBRAS Simon

2A-ENSIMAG

=46ili=E8re Ing=E9ni=E9rie des Syst=E8mes d'Information
Membre Bug-Buster
