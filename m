From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] for TortoiseGit 1.2.1.0
Date: Mon, 16 Nov 2009 22:17:16 -0600
Message-ID: <1976ea660911162017v4fcdcf01l92dda17da622258a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Nov 17 05:17:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAFVk-0005qH-4E
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 05:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbZKQERL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 23:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753824AbZKQERL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 23:17:11 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:30616 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbZKQERK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 23:17:10 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1237198qwe.37
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 20:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=288np/PEuoSOxU8H44XVN19YBUUviZA6Mnci3OGqass=;
        b=L71y3hsRX2+nXUEOZC0mNXWyjaBN6W2eGvYbJka2kXtMLdEQkuGyor4k4Ec4OYcx7d
         yB97u5X5ORSmw7xqJ4JaM/iT1fllK1Sbnc3b17WRCgp5Yw6+XH1rRci+J49NNrBWgXB3
         0z4fzUoNuK+igVITYAFiI06Q+96h6NpHIlVnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=r2fi8HnxyiXWKjRdrsPKu/5EyouU2/6P4VkLpZXyqqgsulD8nm/bXEOnMcb8CK6+bG
         K04PC84IKYlsboaLipfC8gYj/fmMDRi41gG+BCOyMalKoWjMoAtIM0b8sPSh4vFKc2ca
         cMMZnrpWccpWTj4BwxRk2mQlhvwvWvzYrY6HA=
Received: by 10.224.39.144 with SMTP id g16mr5280139qae.260.1258431436073; 
	Mon, 16 Nov 2009 20:17:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133056>

http://tortoisegit.googlecode.com/files/TortoiseGit-1.2.1.0-32bit.msi
http://tortoisegit.googlecode.com/files/TortoiseGit-1.2.1.0-64bit.msi

=3D Release 1.2.1.0 =3D
=3D=3D Features =3D=3D
=A0* Add color success and fail at ProgressDlg

=A0* Log Dialog
=A0 Show work copy to log dialog. User can commit change at log dialog.
=A0 Easy to compare with working copy difference

=A0* Allow Alt+O in commit dialog for OK

=A0* Sync Dialog remote URL support save history

=A0* Add remote branch and current branch at proptery page

=A0* Add no-commit option at merge dialog

=A0* Enable IBugTraqProvide CheckCommit and OnCommitFinished

=3D=3D Bug Fix =3D=3D
=A0* Fixed issue #219: Blame Error when git repository is at root
directory and path use "/"
=A0* Fixed issue #214: installer inserts unused or faulty registry key
=A0* Fixed issue #179: Log dialog lacks information about changed files
=A0* Fixed issue #209: High CPU usage in tortoiseproc.exe & limit line =
number
=A0* Fixed issue #212: Disable the "Select items automaticlly" option
has no effect to commit files dialog
=A0* Fixed issue #209: High CPU usage in tortoiseproc.exe & Append text
to edit ctrl
=A0* Fixed Issue #203: =A0Remote URL select box in sync dialog is not
populated with remotes.
=A0* Fixed Issue #208: =A0During push (from context menu), branches
missing from drop down list.
=A0* Fixed issue #86: Globally sets HOME affecting third-party
applications (GNU Emacs)
=A0* Fixed issue #188: Add Git Properties tab into Windows File Propert=
ies
