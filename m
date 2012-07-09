From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Student project in Ensimag: thanks all!
Date: Mon, 09 Jul 2012 14:36:58 +0200
Message-ID: <vpq7gudxg9h.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kim Thuat NGUYEN <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	Javier ROUCHER IGLESIAS 
	<Javier.Roucher-Iglesias@ensimag.imag.fr>,
	Pavel VOLEK <Pavel.Volek@ensimag.imag.fr>,
	Simon CATHEBRAS <Simon.Cathebras@ensimag.imag.fr>,
	Julien KHAYAT <Julien.Khayat@ensimag.imag.fr>,
	Simon PERRAT <Simon.Perrat@ensimag.imag.fr>,
	Charles ROUSSEL <Charles.Roussel@ensimag.imag.fr>,
	Guillaume SASDY <Guillaume.Sasdy@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 14:37:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoDDF-0000DS-09
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 14:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab2GIMhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 08:37:05 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37204 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497Ab2GIMhE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 08:37:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q69CZZBW028603
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Jul 2012 14:35:35 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SoDD1-0001G4-J1; Mon, 09 Jul 2012 14:36:59 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Jul 2012 14:35:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q69CZZBW028603
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342442137.43692@R3PNcuZWEI1JsqPjuaWwdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201201>

Hi,

For the third year, I offered my students to contribute to open-source
software as part of a school project. This year, we had one team on the
core of Git (who implemented better advices for "git status", the XDG
configuration directory, and "git rebase -i --exec"), and two working on
the Git-mediawiki interface (one worked on new features like support for
mediafiles and authentication using the git credentials mechanism, and
another on an automated testsuite).

The project itself ended a while ago, but some of the patch series
needed extra care to end up in pu. This is now done :-).

A few series have been abandoned ("bisect old/new", and "warn before
rebase/commit"), I've added pointers to the gmane threads on the page
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas
in case someone wants to continue the work.

To conclude the project, I would like to thank everybody for their
participation: the students for their hard work, reviewers for their
support and patience, and of course Junio for being such a good
maintainer!

Looking forward to next years' project!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
