From: Pascal Obry <pascal@obry.net>
Subject: Re: Installing git docs in Cygwin.
Date: Tue, 23 Dec 2008 18:06:43 +0100
Message-ID: <936218FB-9303-4FEE-B610-F48FB2F4FE0C@obry.net>
References: <c115fd3c0812230639v78cee30cqbc7303b02633c8d1@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 5G77)
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:10:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFAlm-0007CY-1y
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 18:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbYLWRI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2008 12:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbYLWRI0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 12:08:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:62974 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbYLWRI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2008 12:08:26 -0500
Received: by nf-out-0910.google.com with SMTP id d3so347298nfc.21
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 09:08:23 -0800 (PST)
Received: by 10.210.79.9 with SMTP id c9mr9053583ebb.108.1230052086451;
        Tue, 23 Dec 2008 09:08:06 -0800 (PST)
Received: from ?10.36.40.6? ([193.253.141.73])
        by mx.google.com with ESMTPS id f6sm3799975nfh.79.2008.12.23.09.08.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Dec 2008 09:08:05 -0800 (PST)
In-Reply-To: <c115fd3c0812230639v78cee30cqbc7303b02633c8d1@mail.gmail.com>
X-Mailer: iPhone Mail (5G77)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103835>


Le 23 d=C3=A9c. 08 =C3=A0 15:39, "Tim Visher" <tim.visher@gmail.com> a =
=C3=A9crit :

> working fine but when I do a `make
> install-doc`, all of the pages compile fine but then make exits after
> exiting git/Documentation with an `Error 2`.
>
> Thoughts?

Are you sure the docs were built fine. I had to revert to a previous =20
version of asciidoc. Just an hint.

Pascal.