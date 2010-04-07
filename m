From: =?utf-8?Q?=C5=81ukasz?= Stelmach <lukasz.stelmach@iem.pw.edu.pl>
Subject: Re: How to log a host (or a repository) of a commit?
Date: Wed, 07 Apr 2010 12:33:55 +0200
Message-ID: <87mxxfft64.fsf@dasa3.iem.pw.edu.pl>
References: <87fx3fniiy.fsf@dasa3.iem.pw.edu.pl>
	<7vk4srouuy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 12:34:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzSaJ-0001eU-10
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 12:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881Ab0DGKeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 06:34:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:42786 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757812Ab0DGKeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 06:34:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NzSaA-0001Z1-SJ
	for git@vger.kernel.org; Wed, 07 Apr 2010 12:34:02 +0200
Received: from dasa3.iem.pw.edu.pl ([194.29.147.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 12:34:02 +0200
Received: from lukasz.stelmach by dasa3.iem.pw.edu.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 12:34:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dasa3.iem.pw.edu.pl
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:mfBrYlkzCXzlKoWgOKbAlRBBQSs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144211>

Junio C Hamano <gitster@pobox.com> writes:

> =C5=81ukasz Stelmach <lukasz.stelmach@iem.pw.edu.pl> writes:
>> Is there a way of logging (an retrieveing this information) where a
>> commit has been created and keeping it when merging/pulling/pushing?
>   http://article.gmane.org/gmane.comp.version-control.git/142549
>
> Linus says:
>     I used to find it convenient to see what machines I had worked on=
>
> Two observations to draw from this:
>
>  - You could use committer identity for that.
>  - Wonder why it is "used to"; perhaps it wasn't useful after all.

I use git to keep track of my org-mode files on few different machines,
so I might have different needs, in this particular case, than software
developers ;)

--=20
Mi=C5=82ego dnia,
=C5=81ukasz Stelmach
