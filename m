From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 1.5.2.0 Release
Date: Thu, 10 Jun 2010 15:50:41 +0800
Message-ID: <AANLkTil2_uLrj7oxVy_8eESkx5r_NYLC3CkVQHUoovkS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com, Git List <git@vger.kernel.org>,
	tortoisegit-announce@googlegroups.com, tortoisegit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Jun 10 09:50:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMcXJ-0002Rg-AF
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 09:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab0FJHuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 03:50:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47055 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985Ab0FJHun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 03:50:43 -0400
Received: by vws17 with SMTP id 17so3495349vws.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 00:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=A5YFR7ghCOMTNWWEyHA7CFPsjnihyxcga1Z9YH/QemY=;
        b=FNyeqo0Uo660BQTiTgoqvbQxqM2ASgW1ChvuWm4StRBUHVPQsKxzQUZSVUV8VnZGUR
         WoH2GhkRs6aQRRciAwC5SgBzlPClyKrIR7crbHBQ8QCL9ncr1M8VmqNNtaaTdp0PikTW
         +wFvGnQubuywsJjLYR7g7bN1PkcnLG31b1MpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Z7o39OlkqRNd8pOt71ggy2kebEvoPU2Z3cu86Nt/meJ6UCrGmlj8xX4PVTtyUelN4l
         c4O7Lh6VGci/zAvBst8LuxOJv9GAiCizEChYrGWwEZLNhmVx9YZADkr5TEJvVNYjJmex
         YGRXXCEasJaUbmExg8cfxSxA1bZK11EYPTA0E=
Received: by 10.224.23.142 with SMTP id r14mr2994921qab.366.1276156241416; 
	Thu, 10 Jun 2010 00:50:41 -0700 (PDT)
Received: by 10.220.200.204 with HTTP; Thu, 10 Jun 2010 00:50:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148839>

Download:

http://code.google.com/p/tortoisegit/downloads/detail?name=3DTortoiseGi=
t-1.5.2.0-32bit.msi
http://code.google.com/p/tortoisegit/downloads/detail?name=3DTortoiseGi=
t-1.5.2.0-64bit.msi

=3D Release 1.5.2.0 =3D
=3D=3D Bug Fix =3D=3D
 * Fixed issue #454: Fix "check Now" can't work at setting dialog
 * Fixed issue #457: Git copy versioned item(s) here adds all unversion=
ed files
 * put pull, push and fetch to external manual.
 * Fixed issue #460: =93Show changes as unified diff=94 compares files =
in
reverse order.
 * Fix history combobox show twice item

=3D Release 1.5.1.0 =3D
=3D=3D Features =3D=3D
 * TortoiseMerege
   Tip show "new file" "delete file" "rename file" status at tortoiseme=
rge

 * TortoiseGitBlame
   Add encode support for blame

 * Sync Dialog
   issue #392: refresh branch info when press "F5"
   Improve user experience when input remote branch and url

 * Log Dialog
   issue #371: Log offer per-file "revert ..." of working dir changes
   Add AntiAlias at show log
   Fix version tree graphic line break at Win 7
   issue #427: Implement enter operation to open a file in the 'Show Lo=
g' window

 * issue #355: Implement Show log like history in the Changed Files
window after a git pull operation

 * ProgressDlg Post Cmd support menubutton

 * Update the translations.txt for translators

 * issue #421: Implement ctrl+a standard 'Select all' facility

 * Change FormatPatch dialog default output directory is project root

 * issue #431: Implement commit button in the git add dialog


=3D=3D Bug Fix =3D=3D
 * *Fixed issue #401: TGitCache.exe keeps open pack-xxx.idx on git repo=
*
 * *Fix issue review patch fail when there are new FilePatchesDlg.cpp*
 * *Fix all file show "+" icon after run git gc*
 * *Fixed issue #449: Files not in the Commit dialog are committed if i=
n index*
 * *Fixed issue #450: Log Messages file list wrong when choose
children dir firstly.*
 * Fixed issue #387: "Automatically check for newer versions every
week" remains disabled
 * Show correct file when Add new file at tortoisemerge
 * Fixed issue #381: About screen of TortoiseMerge shows invalid build
information
 * Fixed issue #382: TGitBlame encoding problem
 * Fixed issue #400: CrLf options are missing in the help file
 * Fixed issue #397: Settings/Set Extended menu/Help button doesn't wor=
k
 * Fixed issue #396: Fix 'Copy paths to clipboard' option
 * Fixed issue #398: Settings/Revision Graph/Help button doesn't work
 * Fixed Issue 392:  Implement refresh button in sync dialog
 * Fixed Issue #395:  [BUG] Infomation error when "Switch the compariso=
n"
 * Fixed issue #385: Bug In properties->Git dialog
 * Clear HOME at gitdll dll after load git config
 * Fixed issue #403: Diff Show changes, but commit not
 * Fix Issue #404:	GetOpenFileName does not work in Cygwin
 * Fixed issue #411: Fix the refresh button operation in 'Check for
modifications' when only file time change.
 * Fixed issue #406: Putty key can't save when clone
 * Fix Issue #419:	wrong error message for empty commit
 * Fixed issue #418: Misleading button title in Sync dialog leads to
loss of uncommitted changes
 * Fixed issue #402: Revert Renamed File Fail
 * Fixed issue #429: When applying patches, tortoise doesn't remember
last file location
 * Fixed issue #428: Blame of an old version
 * Fixed issue #410: Change some menu item name to make it clear
 * Fixed issue #440: Don't enable 'Apply' button until the data are ok
in Settings/Git/Remote
 * Fixed issue #439: Fix the Help action in the TortoiseGitBlame window
 * Fixed issue #438: Slow load Switch/Checkout dialog
 * Fixed issue #221: After resolving all merge conflicts, it's not
obvious the project needs a commit
 * Fixed issue #437: Blame should be available when there are local cha=
nges
 * Fixed issue #444: Crash rebase  dialog when press ESC and move split=
 bar
 * Fixed issue #445: Resolve conflict does not delete temporary files
 * Fixed issue #446: TortoiseMerge crash when "Edit Conflicts"
 * Fixed issue #405: Merge commit message when there is a conflict
