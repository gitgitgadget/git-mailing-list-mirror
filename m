From: dag@cray.com (David A. Greene)
Subject: Re: git-subtree Ready for Inspection
Date: Thu, 09 Feb 2012 15:52:12 -0600
Message-ID: <nngobt78yk3.fsf@transit.us.cray.com>
References: <87liocoayz.fsf@smith.obbligato.org>
	<CAEY4ZpPs_3Ym=3gsVzwwXFAmk1DbgvvcdnK3p0WUaCOWg9TpMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "David A. Greene" <greened@obbligato.org>, Jan <jk@jk.gs>,
	git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:52:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvbuq-00037s-Qe
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758277Ab2BIVw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 16:52:27 -0500
Received: from exprod6og114.obsmtp.com ([64.18.1.33]:37954 "EHLO
	exprod6og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2BIVwY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 16:52:24 -0500
Received: from stplmr01.us.cray.com ([136.162.34.13]) (using TLSv1) by exprod6ob114.postini.com ([64.18.5.12]) with SMTP
	ID DSNKTzRADVoMAgE8O5fIWjTEONxBfKLUmXLt@postini.com; Thu, 09 Feb 2012 13:52:23 PST
Received: from transit.us.cray.com (transit.us.cray.com [172.31.17.53])
	by stplmr01.us.cray.com (8.14.3/8.13.8/hubv2-LastChangedRevision: 12441) with ESMTP id q19LqDiP017059;
	Thu, 9 Feb 2012 15:52:13 -0600
Received: from transit.us.cray.com (localhost [127.0.0.1])
	by transit.us.cray.com (8.14.3/8.13.6/client-5260) with ESMTP id q19LqCmG010585;
	Thu, 9 Feb 2012 15:52:12 -0600
Received: (from dag@localhost)
	by transit.us.cray.com (8.14.3/8.12.8/Submit) id q19LqCU9010584;
	Thu, 9 Feb 2012 15:52:12 -0600
In-Reply-To: <CAEY4ZpPs_3Ym=3gsVzwwXFAmk1DbgvvcdnK3p0WUaCOWg9TpMQ@mail.gmail.com>
	(Nazri Ramliy's message of "Thu, 9 Feb 2012 13:17:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190329>

Nazri Ramliy <ayiehere@gmail.com> writes:

> On Thu, Feb 9, 2012 at 1:02 PM, David A. Greene <greened@obbligato.or=
g> wrote:
>> Do you mean running gitweb? =C2=A0Are you not able to access the abo=
ve
>> repository? =C2=A0I can do that if it makes things easier but it wil=
l take a
>> bit of time.
>
> It asks for password:
>
> $ git clone  gitolite@sources.obbligato.org:git.git
> Cloning into 'git'...
> gitolite@sources.obbligato.org's password:

Grr...Ok, I'll see if I can fix it or I will put up a gitweb fork.

                       -Dave
