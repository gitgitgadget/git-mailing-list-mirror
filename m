From: Kris Shannon <kris@shannon.id.au>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Tue, 3 Aug 2010 18:47:12 +1000
Message-ID: <AANLkTi=uPHiS2S2hR4=0oBC=s3SyEP_qo3+n8FNHkFEV@mail.gmail.com>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<4C52E6E1.20101@xiplink.com>
	<vpqd3u53sd2.fsf@bauges.imag.fr>
	<AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 10:47:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgD9e-0007z2-Cp
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 10:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab0HCIrP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 04:47:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44338 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab0HCIrO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 04:47:14 -0400
Received: by bwz1 with SMTP id 1so1795770bwz.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 01:47:13 -0700 (PDT)
Received: by 10.204.140.219 with SMTP id j27mr5008388bku.153.1280825232911; 
	Tue, 03 Aug 2010 01:47:12 -0700 (PDT)
Received: by 10.204.74.93 with HTTP; Tue, 3 Aug 2010 01:47:12 -0700 (PDT)
In-Reply-To: <AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152492>

On 31 July 2010 23:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
> On Fri, Jul 30, 2010 at 15:24, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
> > Marc Branchaud <marcnarc@xiplink.com> writes:
> >
> >>> The name of the command may be subject to discussions. I've chose=
n
> >>> "run", but maybe "shell" would be OK too. In both cases, it doesn=
't
> >>> allow the one-letter version since both "r" and "s" are already u=
sed.
> >>
> >> "exec" with one-letter "x"?
> >
> > Thanks, that sounds good, yes. Any other thought?
>
> I like "exec".
or (t)est.
