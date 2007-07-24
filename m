From: Thierry Parmentelat <thierry.parmentelat@sophia.inria.fr>
Subject: git documentation - user manual html version has wierd characters
 all over the place
Date: Tue, 24 Jul 2007 10:37:47 +0200
Message-ID: <46A5BA5B.3020006@sophia.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 10:47:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDG38-0007Lq-58
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 10:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbXGXIrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Jul 2007 04:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbXGXIrS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 04:47:18 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:3363 "EHLO
	mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752933AbXGXIrR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 04:47:17 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2007 04:47:17 EDT
X-IronPort-AV: E=Sophos;i="4.16,573,1175464800"; 
   d="scan'208";a="527211"
Received: from muck.inria.fr ([138.96.250.111])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Jul 2007 10:37:19 +0200
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53536>

Hi there

just so you know: the html page here
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html

has all its examples -- the ones in a <div class=3Dliterallayout> -- wi=
th=20
wierd character inserted
e.g. in the Preface
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#id2647=
04
What I see as the first example displays like this
$=EF=BF=BDman=EF=BF=BDgit-clone

the same symptom appears in chapter titles
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#reposi=
tories-and-branches
displays


    Chapter=EF=BF=BD1.=EF=BF=BDRepositories and Branches

=3D=3D=3D
I am using the latest firefox 2.0.0.5 on macos 10.4.10 US version


-- thanks
