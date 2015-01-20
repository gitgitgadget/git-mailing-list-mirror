From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 00/24] nd/untracked-cache update
Date: Tue, 20 Jan 2015 20:28:03 +0100
Message-ID: <54BEAC43.8000605@web.de>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 20:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDeTJ-00074l-62
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 20:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbbATT2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 14:28:12 -0500
Received: from mout.web.de ([212.227.15.14]:54377 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbbATT2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 14:28:11 -0500
Received: from macce.local ([78.68.171.36]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LqGCu-1XZw0K1IHo-00dmBO; Tue, 20 Jan 2015 20:28:04
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:LB+ZCyV6A8ZgGP8bUkfYleouALMETDwb5v1P5gwvxRZUFxCMnxj
 D6ZJqB0OCg5zzR2/mzQnGp3GmGkBXnlDta6LqIwpxq6ZGwHF9tXqeTHnMdkUgrZVC9Xza+R
 l7Ze1U1HJ9TNoXXtMI9T80rLndDJfnWA8cqQE/wPaHqr17tuBhiREW5U9IjO/9YSslpkcJI
 ayZaY6zlBmtrijgvu2HnA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262683>

On 2015-01-20 14.03, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> Sorry for this really late update. This fixes bugs in extension
> writing code (10/24), support using the same cache from different
> hosts (23/24), and adds a new bug to point the user to untracked cach=
e from
> 'git status -uno' (new patch 24/24)
>=20
> Diff from 'pu'
=20
Thanks for working on this, as I think it is a major improvement.

Do you have a commit on a public repo ?
pu + your serious, or master + V3 + this delta ?
