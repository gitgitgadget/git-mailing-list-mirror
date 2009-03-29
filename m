From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 1/4] Documentation: enhance branch.<name>.{remote,merge}
Date: Sun, 29 Mar 2009 12:54:30 +0200
Message-ID: <adf1fd3d0903290354y7ac26542r8d82309a7247eacc@mail.gmail.com>
References: <1238281804-30290-1-git-send-email-santi@agolina.net>
	 <1238281804-30290-2-git-send-email-santi@agolina.net>
	 <76718490903281838s1bc7e908l4702cf9ab020189@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 12:56:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnsgO-0004fX-6F
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 12:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbZC2Kye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 06:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbZC2Kyd
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 06:54:33 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:39810 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZC2Kyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Mar 2009 06:54:33 -0400
Received: by fxm2 with SMTP id 2so1576281fxm.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 03:54:30 -0700 (PDT)
Received: by 10.103.182.3 with SMTP id j3mr1183562mup.107.1238324070119; Sun, 
	29 Mar 2009 03:54:30 -0700 (PDT)
In-Reply-To: <76718490903281838s1bc7e908l4702cf9ab020189@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115016>

2009/3/29 Jay Soffian <jaysoffian@gmail.com>:
> On Sat, Mar 28, 2009 at 7:10 PM, Santi B=E9jar <santi@agolina.net> wr=
ote:
>> =A0branch.<name>.merge::
>> + =A0 =A0 =A0 It defines, together with branch.<name>.remote, the tr=
acking branch
>> + =A0 =A0 =A0 for the current branch. It tells 'git-fetch'/'git-pull=
' which
>> + =A0 =A0 =A0 branch to merge.
>
> I think it would be clearer to say "the upstream branch for the
> current branch", since
> it could very well be a local branch, not necessarily a remote tracki=
ng branch.

It makes sense, thanks.

Santi
