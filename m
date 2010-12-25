From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] close file on error in read_mmfile()
Date: Sat, 25 Dec 2010 13:44:56 +0100
Message-ID: <4D15E748.8020102@lsrfire.ath.cx>
References: <4D15E5D6.2040800@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Ettl <ettl.martin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 25 13:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWTV3-00039A-L4
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 13:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608Ab0LYMpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Dec 2010 07:45:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:54308 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0LYMpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Dec 2010 07:45:09 -0500
Received: from [10.0.1.102] (p4FFDA3B9.dip.t-dialin.net [79.253.163.185])
	by india601.server4you.de (Postfix) with ESMTPSA id 8462D2F8046;
	Sat, 25 Dec 2010 13:45:07 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D15E5D6.2040800@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164174>

Am 25.12.2010 13:38, schrieb Ren=E9 Scharfe:
> Reported in http://qa.debian.org/daca/cppcheck/sid/git_1.7.2.3-2.2.ht=
ml.

Oh, and also in http://thread.gmane.org/gmane.comp.version-control.git/=
123042.

Ren=E9
