From: Meinrad Recheis <meinrad.recheis@gmail.com>
Subject: [ANN] git# (GitSharp) project status
Date: Sun, 9 Aug 2009 08:41:51 +0200
Message-ID: <43d756720908082341p2f2a7a75yb1fdf85982fdb8f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 08:42:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma26e-0005WV-K5
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 08:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbZHIGlw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2009 02:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbZHIGlw
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 02:41:52 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:56192 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbZHIGlw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 02:41:52 -0400
Received: by bwz19 with SMTP id 19so2091381bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 23:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=NnEER5teTxAcwR794AM08Mz8o76gx59RN7u6eKAFw/k=;
        b=VZYqos2nl2PaENtm5+ZEBhQHpgDz+f7rS6kVhzNhUKJm2nKFfDaCYUIIWA7I4MRvJD
         aMn4a8aOin217ausNhE+sMKgf5z/TltX8dZxxmgjV++uLiiiss2mVprd8qPKkniJYaoD
         lYxxrITSEPMT2Ki0N2sEEcyTqerXSaIu8evN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vbysza1YHIWJRr4us6ISvjVMMMwnfQk8NE0wJRMuEO09eXU8As7fVZURbtkT5jjXlA
         P4GY6YBlEpytJDMZ4YWwZWG9qFz+DUmU2Q+ICbgwJl1nhvkL+DPVCJ1ZWJoLifFXAOoO
         OXqShkYaga9cZcs4cPWST7uFLNPSjRQ0/N8b4=
Received: by 10.223.121.6 with SMTP id f6mr35031far.51.1249800111751; Sat, 08 
	Aug 2009 23:41:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125321>

Hi,
Thanks to massive contributions from various people the project
GitSharp has progressed very fast.

GitSharp now counts about 17753 lines of code, the jgit.lib snapshot
we are porting from counts 24588 lines. This means that roughly 72% of
the porting work are done! About two months ago, when I announced the
project on this list only about 25% had been done.
There is also still much testing work to do=A0(426 tests of=A0approx.=A0=
1000
tests are ported)=A0and a lot of bugs to fix (28 tests are failing) til=
l
all the ported code may be considered as correct.

I want to say thanks to the git community, to the jgit folks and to
all who contributed to GitSharp!
=46or more info visit=A0http://www.eqqon.com/index.php/GitSharp

Cheers,
-- henon
