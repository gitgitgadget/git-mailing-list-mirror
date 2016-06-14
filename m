From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: problems installing GIT on my MAC OS X 10.11.5
Date: Tue, 14 Jun 2016 18:14:41 +0200
Message-ID: <f4c72626-1bd5-0b26-a18a-49feed67a742@web.de>
References: <1F59C8B7-AF53-4C84-9428-5A4AB80DB295@gmail.com>
 <20160614190641.0d0ba5344e52304e16ca4f52@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Maria Jose Fernandez <mjose.fernandezj@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 18:27:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCqzL-0000dM-L2
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 18:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbcFNQOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2016 12:14:47 -0400
Received: from mout.web.de ([212.227.17.11]:63148 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbcFNQOq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 12:14:46 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MUWFj-1anJbt0HXX-00RIE4; Tue, 14 Jun 2016 18:14:42
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
In-Reply-To: <20160614190641.0d0ba5344e52304e16ca4f52@domain007.com>
X-Provags-ID: V03:K0:Tpv6QSP63fnIiRUI9v2o4gcSX/uZxzDPeQ4ikZykq6uE2f8BHkh
 pjAH9k8GOGVUk8F/tgMlhpRKFuQB/d+q2+jw5836/MGkjvz7urlkfsXbAtAkmnd/Tnm5FMa
 ZrRfJza1NHBFLHFzi/urOlOcvz9YBiHj2QJIIwo/l4z+Xz1rCGD4YULorpkK0qHFthsuvq/
 ACEA++09IOSZPFpm0Pemw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vYrvk6CD6DM=:uBI8VrSVxuPxbuBi4hS/1w
 6hbijib2gK5nO1eTXW/zGsRedz1Ld95XMwf3C582zASIkgzTRoIyHgwX9E+lcya7rmkRap1iN
 QGXPcKmUbTTHSuRlclE0tFaZk3jvKKp0eteABf1BxGzph2u6qVe5AqjCLSczrzFYzPJSrhmDf
 jgwSww+RdoYxpgtwbZEEacQj6wKaC/6eDyIalWf1shaxzN2vqXTASGDGjWEOnQQN/OrHOGDyC
 nBxVe0wQX8u4Gz4qo/COv2I3o52du5a97bQ0BGkJ6jXrvlLQiF49ErXqKUY5pehaEo60v0EZe
 H9DW5NMxKId0+MvE9RHWPr6FbZxRZLrvnl6TcYP40NC90i3TIsJCgiK5b8+/T1AnvRI6xVX6F
 vvdflrqE05oWj4sHSXEMv0l5qNJ8PsBLyuyKwCryY2WZPhUZoWnF9Bx5atX2Dais7053zJHF8
 JgpfpENPBDY3tUsw/mQp+IGKFRyoQPVmZwtKPQ4WS1JbQVzkHx2OMUAFEoSOFhXgVMk+i0joq
 qkmwpEjf92FmaKvCQfb0+5jDXEk3Rfrrf1xjmW/BWT09VC9MUP9GlyVVSe1QNRAcGcuh9G31X
 PwfwiqVR1LLpxjgTCRuUxeo6US6BTD1P+CBkg6QgbB7modL5AV2mT0PY2kgjvGCYjyVClh1RX
 Pz/xJ7pR/krUS1PPcKyTU9RMXJvePJytQPVj9EuoC4uLnNe9i8azt1qlFBuHJHv8lTvQyaTdq
 7RpfgiQCEFfIjHTfQ79Gz7I3xNTRokNzU/GAN/KQI5S9hn8walez+/T2QfJ7AQcfO1xTFM7z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297302>

On 14.06.16 18:06, Konstantin Khomoutov wrote:
> On Tue, 14 Jun 2016 16:56:15 +0100
> Maria Jose Fernandez <mjose.fernandezj@gmail.com> wrote:
>=20
>> I am doing a data science course and need to download GIT but for
>> some reason I can=E2=80=99t installed it. I called Apple but they co=
uldn=E2=80=99t
>> help and suggested me to contact you guys.
>=20
> So you proceeded to http://git-scm.com/download/mac fetched the
> installer, then found the downloaded file in the Finder, clicked it -=
-
> and then what happened?
> --

Not sure, we need to verify first, what had happened.

Typically, if you install Xcode, there is a program
wrapper called git, saying that you need to install it
as part of Xcode.

You can do this.
You can go to http://git-scm.com/download/mac.
You can install git via homebrew, via fink or mac ports.

So it could be nice to know what exactly happened, please.
