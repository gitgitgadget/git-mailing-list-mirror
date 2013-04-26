From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t9501: Do not use export X=Y
Date: Fri, 26 Apr 2013 11:21:39 +0200
Message-ID: <517A4723.7050309@web.de>
References: <201304252049.00811.tboegi@web.de> <7va9om2v9z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 11:22:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVeqt-0004TM-BJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 11:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290Ab3DZJVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Apr 2013 05:21:54 -0400
Received: from mout.web.de ([212.227.15.4]:62313 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759515Ab3DZJVx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 05:21:53 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LwHxK-1UYWyb37fC-017TT0; Fri, 26 Apr 2013 11:21:39
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7va9om2v9z.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:7g3jq5Pl3Ovi6huYo6zua3PKGaKN3rdrfCYTQPTtPOf
 qhH6r2GSpOjBJbptHtcJNn+DJeVBh03Hx9tcIYsBQJoUYCp4st
 2lSKmOn4vcrLMid2wSBF/ZZixW3+0xiopDkUPqSvoP8YkWSMPh
 dFXzwK1FcpCR6A41dWgDrFoVm5iwDeqL3/cpxbdp7AqB61aIN2
 2SE7YQQPnNKLCzZURabDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222522>

On 2013-04-25 22.46, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Spilt lines like export X=3DY into 2 lines:
>> X=3DY
>> export X
>=20
> That can be read from the patch text.
>=20
> If you are going to spend three lines, please describe why it has to
> be split; that would help educate developers new to the codebase.
>=20
So true,
writing good commit messages is not easy.
and this was a good example for a bad example

Side questions:
Which shells of which OS/distribution do not understand export X=3DY?
