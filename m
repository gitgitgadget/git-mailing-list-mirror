From: Dilip M <dilipm79@gmail.com>
Subject: Re: Installing full fledged git on solaris?
Date: Sun, 11 Oct 2009 19:08:00 +0530
Message-ID: <c94f8e120910110638g63914c9au7eb4cf8e6395e5ed@mail.gmail.com>
References: <c94f8e120910110526r68e4abe1l269dc4b3ab22bac3@mail.gmail.com> 
	<1255265817-sup-4123@ntdws12.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sun Oct 11 15:40:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwyei-00052G-ON
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 15:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbZJKNi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 09:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbZJKNi4
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 09:38:56 -0400
Received: from mail-pz0-f188.google.com ([209.85.222.188]:48043 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbZJKNi4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 09:38:56 -0400
Received: by pzk26 with SMTP id 26so7421147pzk.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 06:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=AWlrCtlJxQgzy3coIo4jgtHuOPTXj7Wjo4kZUv1w1wY=;
        b=N26y1vAAr6zSwpaJhcSym6r1R/9TKm4QSTlXXoK/hZQkOJcV8PJrdLT/WNMwRhQZ2P
         2gpC1AeX/lGztvlv/rH1yuEPFG1pvN+qm84zvapp0AMVKjDcOUQAmEeW7tN40Ne3ollZ
         81OxOmkbeq3Jsgf1KiHpkfSRzimb++hjCNgco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CCeefcdS3Bd4cpzec9vrmj2QKi96wi2tfF9Bb+KT7yorPicL4TvA55RM1+wu96jEHo
         giJFuW+pCr4aaVPDXd85zcHHKRboFLyQ4P/LdqKMCRKrKfkES1sBHIAGMHsoW+lbrr41
         MHQkV5pfioD/5f8bDhHeyRfcQHjRIZIw+Gt4I=
Received: by 10.140.165.7 with SMTP id n7mr324441rve.270.1255268300050; Sun, 
	11 Oct 2009 06:38:20 -0700 (PDT)
In-Reply-To: <1255265817-sup-4123@ntdws12.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129924>

On Sun, Oct 11, 2009 at 6:42 PM, Ben Walton <bwalton@artsci.utoronto.ca=
> wrote:
=2E..snip...

> If your intent is to build it yourself, let me know and I'll share
> with you the build recipe I use, which will outline (within the CSW
> stack) which packages are used for compilation and which for runtime
> dependencies. =A0You should be able to translate it to use the
> libs/tools available to solaris 10 (that aren't in 8, which we also
> support).

Please share...

--=20
Dilip
