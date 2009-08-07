From: Tim Harper <timcharper@gmail.com>
Subject: Re: [ANNOUNCE] tortoisegit 0.9.1.0
Date: Thu, 6 Aug 2009 23:25:26 -0600
Message-ID: <e1a5e9a00908062225y112984d9gc0486ebcda25ab57@mail.gmail.com>
References: <1976ea660908050700u9b16a8ci169825b121f02cb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com, tortoisegit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 07:25:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZHxi-0001nL-PD
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 07:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbZHGFZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Aug 2009 01:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbZHGFZq
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 01:25:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:42050 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZHGFZp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Aug 2009 01:25:45 -0400
Received: by rv-out-0506.google.com with SMTP id k40so87432rvb.5
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 22:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KK17rrWlmUsMlI2fSggs0AKUucngfBGO3Z4FTkn8B10=;
        b=iK2ZhXd6kIJsLxze0dHgads59fo1P1FSW1B2Q4gLX3KC3yaQl8AHmQ9FIJX4TK0Iop
         ir8kmM1NhxijTF9Uh17IUV7XOAsCUwqrR97gT74sbmMWTMT4z2yMWH5CuhwQXyh80lsA
         sNqZ+qdMBbMLczKQnrsmbr8UjJTUAGK2bxZro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bvCiyl8G1H5QJ6ASGKy4+GGFMzmyvP6KsyfB3qJKaipwheXz84TF4zNYbgKpOhSyEs
         QFjn5WpPeolW3DK1kNsY6Y8o/X7gEB6FqhZh5F1MMBN2fvnHwUUfP9PUYy1NCkw3oTfE
         GYsEbrQMBvYdqurniyLhA1VDXZqDkQ527ZCKQ=
Received: by 10.140.208.15 with SMTP id f15mr331930rvg.49.1249622746101; Thu, 
	06 Aug 2009 22:25:46 -0700 (PDT)
In-Reply-To: <1976ea660908050700u9b16a8ci169825b121f02cb9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125179>

On Wed, Aug 5, 2009 at 8:00 AM, Frank Li<lznuaa@gmail.com> wrote:
> http://tortoisegit.googlecode.com/files/TortoiseGit-0.9.1.0-64bit.msi
> http://tortoisegit.googlecode.com/files/TortoiseGit-0.9.1.0-32bit.msi
>
> =3D Release 0.9.1.0 =3D
> =3D=3D Features =3D=3D
>
> =C2=A0* Add Sync Dialog like TortoiseHg.
> =C2=A0 Put pull, fetch, push, apply patch and email patch together. Y=
ou
> can Know what change pull and push. Show changed file list.
>
> =C2=A0* Enhance Rebase dialog. Add force rebase checkbox. Disable sta=
rt
> button when no item rebase. Don't show merge commit
>
> =C2=A0* Add post action button for rebase dialog. Such as send patch =
by email
> =C2=A0 After rebase, you can click button to send patch email directl=
y.
>
> =C2=A0* Add =C2=A0launch rebase option at fetch dialog.
>
> =C2=A0* Improve push dialog.
> =C2=A0 Default settings from local repositories pushing to remote
> repository Choose track remote and remote branch! Add short-cut at
> push dialog
> =C2=A0 Add "F5" refresh remote and branch info at push dialog
>
> =C2=A0* Add Clean Untracked version type
> =C2=A0 User can choose clean untracked file, clean ignore file, clean=
 all.
>
> =C2=A0* Enhancement: "Git Clone" from SVN repository with additional =
start
> revision number option (-r xxx:HEAD)
>
> =C2=A0* Improve Commit dialog
> =C2=A0 Add recent message back to context menu.
> =C2=A0 The "Message" field of the Commit dialog should have a shortcu=
t key
> (Alt-M is a good choice)
> =C2=A0 Make "Whole project" directory checked by default when the use=
r
> commits in the root of the project.
> =C2=A0 When using "Commit" to also add files, if you forget to check =
the
> new files and press "Ok", you get the dialog "Nothing Commit" and the=
n
> the whole Commit dialog closes. Keep the dialog open after this
> message.
>
>
> =C2=A0* Improve setting dialog
> =C2=A0 Settings: Git -> Remote: When creating the first remote, the
> "Remote" should have "origin" as default.
> =C2=A0 Fix setting dialog remote page tab order
> =C2=A0 Push: When you press "Manage" under Destinations, the Settings
> dialog opening should have "Git -> Remote" selected by default.
>
> =3D=3D Bug Fix =3D=3D
> =C2=A0* Fixed issue #124: Incorrect Date header in patch e-mail
> =C2=A0* Fixed issue #122: Garbage text in "Git Command Progress" /
> suspected buffer overflow Improve commit speed when many added files.
> =C2=A0* Fixed issue #121: Refresh in "Check for modifications" dialog
> duplicates added state entries when new repository
> =C2=A0* Fixed issue #71: (TortoiseProc problem)Icon Overlays don't wo=
rk in
> root of drive When m_CurrentDir =3DC:\, not C:, =C2=A0pathlist calula=
te
> wrong.
> =C2=A0* Fixed issue #116: SVN Rebase doesn't work
> =C2=A0* Fixed issue #115: Windows XP: Initial "Git Clone..." from SVN
> Repository doesn't work
> =C2=A0* Fix "ESC" =3D "push" when after commit and Add Alt-P =C2=A0fo=
r Push
> =C2=A0* Fixed issue #111: Undo Add does not work (keep added file) an=
d
> enable "F5" at revert dialog
> =C2=A0* Fixed issue #109: clone on bare local repository fails Clear =
trail
> slash \ or/
> =C2=A0* Fixed issue #104: Doubleclicking changed submodule dir in Che=
ck For
> Modifications dlg, crashes TGit Fix log dialog double click submodule
> problem
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordo
mo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>

=46rank Li,

Thank you for your work on TortoiseGit.  I feel more and more
confident recommending git to my winders friends because of it.

Tim
