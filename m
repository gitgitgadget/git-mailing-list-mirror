From: "franky" <yinping@kooxoo.com>
Subject: RE: Is it possible for git to support binary differencing for binary files?
Date: Fri, 12 Oct 2007 11:04:49 +0800
Message-ID: <20071012030452.DA0D07E6F@mail.kooxoo.com>
References: <8c5c35580710111027t127fe9d5qe098d5372783b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Lars Hjemli'" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 05:09:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgAqo-0006zx-Iu
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 05:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbXJLDFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2007 23:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755451AbXJLDFI
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 23:05:08 -0400
Received: from mail.kooxoo.com ([60.28.194.208]:46133 "EHLO mail.kooxoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755875AbXJLDFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2007 23:05:05 -0400
Received: from yinping (unknown [124.42.17.129])
	by mail.kooxoo.com (Postfix) with ESMTP id DA0D07E6F;
	Fri, 12 Oct 2007 11:04:52 +0800 (CST)
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcgMK/X6gkqI+Tk1Rqup6LgVpcoxnwAUJg7A
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
In-Reply-To: <8c5c35580710111027t127fe9d5qe098d5372783b0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60651>

This is also useful. 3x. However, git-gc is what I want.

-----Original Message-----
=46rom: Lars Hjemli [mailto:hjemli@gmail.com]=20
Sent: Friday, October 12, 2007 1:27 AM
To: =D2=F8=C6=BD
Cc: git@vger.kernel.org
Subject: Re: Is it possible for git to support binary differencing for
binary files?

On 10/11/07, =D2=F8=C6=BD <yinping@kooxoo.com> wrote:
> Storing binary files as deltas is helpful to keep source and binary f=
iles
> together and in sync  So is it possible for git to do that as svn. Th=
is is
> my only pain when using git.

Could 'git diff --binary' and 'git apply --binary' be what you're looki=
ng
for?

--=20
larsh
