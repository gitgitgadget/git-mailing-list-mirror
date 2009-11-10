From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: gitk : french translation
Date: Tue, 10 Nov 2009 19:05:30 +0100
Message-ID: <9f50533b0911101005j4839bd93ld69edfa94241c755@mail.gmail.com>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Emmanuel Trillaud
X-From: git-owner@vger.kernel.org Tue Nov 10 19:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7v66-0004KK-GR
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 19:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbZKJSFb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754195AbZKJSF3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 13:05:29 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:52664 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042AbZKJSF0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 13:05:26 -0500
Received: by ewy3 with SMTP id 3so299701ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 10:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U3ZPS0YIsG0vFAMB0XY8eiZA1/kpjHaLCl5hsDLpAvc=;
        b=lvmCTxkvHPmT1O9gVPmDZ5KgHc9S1nrOiUVB56crT4HJLC1Iy7asL9cgwO2YTedAZF
         wHNDkY9fK4OH/Q/q/secqVik+P8oYmxK5MgDi648zfMkXqJ2RKYXx7QW+bDnrQX6mTe2
         1Wdc544zKsdInMDXQYYvU+m8nT8xzZeXOTD4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XQrO7rN/ZOmfplqLiP6WhVBJsPnqhYjUmSEuT0d+xUapRsahrMOWtaD1Dxrj9zYgGt
         Uq1JC1orO/dTN+V7rO5ONxVb+RZI2ZWYbDDUmxhQ6YzS64hwZ79DNUQ8Kxer1/WLivR2
         N/YZ6WkVOrxyG7pfJXn9UIYPdF8IqdlM62qQk=
Received: by 10.216.86.200 with SMTP id w50mr123377wee.173.1257876330964; Tue, 
	10 Nov 2009 10:05:30 -0800 (PST)
In-Reply-To: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132579>

Here is a glossary which contains the Git words and the proposed transl=
ations.

Terme : Traduction(gitk) : Traduction(git-gui)

Branch : branche :
To blame : bl=C3=A2mer : bl=C3=A2mer
Commit : commit : commit
to commit : commiter : commiter
commiter : auteur du commit : commiteur
Check out : R=C3=A9cup=C3=A9rer : charger
to cherry-pick : Ceuillir
Diff : Diff=C3=A9rence : Diff
Index : Index
Tag : Tag : Marque (tag)
Revision : R=C3=A9vision : R=C3=A9vision
Merge : fusion : fusion
to merge : fusionner : fusionner
Head : Head : Head
to reset : R=C3=A9initialiser : R=C3=A9initialiser
reset : r=C3=A9initialisation ;
Hard (Reset) : Dure :
Mixed (reset) : Hybride :
Soft (Reset) : Douce :
Patch : Patch :
To stage : Indexer :

some RFCs :
I am ok with the translation of "patch" by "patch" since it is use in
france in other context
I prefer to translate "Diff" by "Diff=C3=A9rences" _especially_ when we=
 are
talking about the action of making a "diff"
translation of "Hard", "Mixed", "Soft" in the Reset context
translation of "cherry-pick". For this one we could use "<translation>
(<english-word>) ..." as suggest previously.

Best regards

Emmanuel
