From: Meinrad Recheis <meinrad.recheis@gmail.com>
Subject: [ANN] gitsharp version 0.1.0 released
Date: Sat, 26 Sep 2009 19:36:52 +0200
Message-ID: <43d756720909261036h30251b80k3a08f9319239b4ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: gitsharp@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Sep 26 19:37:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrbCh-0005ZT-DB
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 19:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbZIZRgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 13:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbZIZRgu
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 13:36:50 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55455 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZIZRgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 13:36:49 -0400
Received: by fxm18 with SMTP id 18so2856766fxm.17
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=eA4xK2FS6QmfGq6197h5/xKmp34WKbqkud2ALsywM4o=;
        b=JdggjY/b0Ojgh7UJChW4S0Eg4AxLQCo81iXSEClQR9zG9g+P92/MT5eBsPDqkycUTZ
         /wrZeRUhBkBUlxmKNbC7oTsnfsnPngb+Lx7QGWWYSH2/YCG9uojJ2EULKosbuCn49rxS
         72AOUQ52Sht9Ad2kx93J7lqOJJ6QpHchlpA58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=qpShoVNVFVa9yaHZBhoVh/8vmcmBNnOWg247KWtfYEUGnpFUpWG192oIAKaWeda2L/
         BMC/IJhkexayjgxZ3c2ece8eLjpXFbKnam56arL5FxIM75X6B8wTDu5fj1wn1pRvcHbu
         Q+SDL7amEsnYHt8ilHu4wtZhfzy9ytWj6ToqY=
Received: by 10.223.2.205 with SMTP id 13mr380753fak.83.1253986612488; Sat, 26 
	Sep 2009 10:36:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129160>

Hello git community,

Thanks to our active development community git# is quickly making
progress. The library GitSharp.dll is about 95% complete and we have
started creating a command line interface which shall be equivalent to
the original git. It already executes the commands "init" and "clone"
(not yet via SSH), some other commands are prepared as stubs. Please
note that not yet all tests are passing and that we are still working
on porting over jgit's changes from the last few months.

Download the binaries and find more information about this release at
http://www.eqqon.com/index.php/GitSharp/v0.1.0

Enjoy our first release and have a nice weekend,
-- henon
