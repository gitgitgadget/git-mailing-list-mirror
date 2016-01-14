From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [issue?]'git branch -D' case sensitive issue
Date: Thu, 14 Jan 2016 17:42:19 +0100
Message-ID: <5697CFEB.4090308@web.de>
References: <CAB4fgE81JHzU=KmN9e=pjsurboipQ3K-pMu-26j+o+FU5G7tQQ@mail.gmail.com>
 <56978BA9.2010005@web.de>
 <CAB4fgE-UbTD6AkTaxyknJ+3ggtzRdYN43wgsamTXOYmGqDQ3_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?6YOt6IW+6aOe?= <tfguo369@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:42:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkyh-00061o-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038AbcANQmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2016 11:42:23 -0500
Received: from mout.web.de ([212.227.17.12]:61550 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754570AbcANQmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:42:23 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M9GN8-1aT7pL0HrK-00CeRm; Thu, 14 Jan 2016 17:42:21
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <CAB4fgE-UbTD6AkTaxyknJ+3ggtzRdYN43wgsamTXOYmGqDQ3_A@mail.gmail.com>
X-Provags-ID: V03:K0:ptOa8SPVWVNpFFTLWzuN5hAmjvjCCjmejDnSl1vsUqFq+dya6oo
 XzrHC3zmbimFxMoxCij4qr3+ej3pZFDZ5vpcQIqf8+ITUiGwDMRrtMaeBMM0lmsiO+eer8g
 0fpSn7uTr0veWXG/PBn1GnoUGny8gK/oCRKkeO+Me9CoDLCFtZX0Yw0IddCEsrR6+Bnwom4
 ncqA/dsoOdCoAXJeUoZKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QPGcalPEcwk=:QTsvav/eHTbdPr7ILZUP6a
 qHSg9hYF7zXWO17AYdUCDOpfHnF/4Uoh/xAQjzc0ZbpHtO1p3Q0nm+AoFHxEc0oCT8g+3f5aI
 kETaXnFFImwCkq4TZFZsQK1ayAErdeku4Isw/VDCbsBqgk3Qke8HnM5fTr+pWylMAvJ72NTL+
 AqByOUW0agWSTmfuC1vRCzdkFGUNaF8wbJyd1HVB7up5kb9iiCS8W8UYiysNXWXcAINOANj1s
 +4oOR/YVkYzMOlCvbrLtyhA5jLJ3gnJLN85SxMiKBgNwiAA0LdIUqO8k6CTNIVGz3Bf4m/Toy
 Zebkxf3XneqoGaAHbCb76gH1anc2GD7iPjm8BR0R4446Cr0f4/Cs4Jd9rn+vR8tIuhmRcYYsp
 n5hHq2xgbolnB5WzC81998KUQz7TfJWP1RnUdE01S4Zg1Ghp3Co9kLMhwIpO7pVwqzVrwc7Se
 Z5aOH7fXYiKnDW4uXTIi8ihB1bDKISDrte8P+MqQfJsT/DrWjnjQAegjEtbKSKz0i7pMAKpIc
 2eWZCQ2FMjsj8hMGvh4m3Hr3+ggMsT+VaZO6RChrj9qIoB9L29Q2E/ebr4vR9JCXz4sBfUejx
 ++O/Sy0sgB9pLGXb+2njpJeMKVMPTOcbT5MeEN4crLdtmNt/T+/bzM7C3qcbNvobB2X908TZa
 Hh00NXe4rCsJKvLgzKGSzfUbA9FQ1RJ98rJ9Ugz+txFDvgwT0ZFIwDtWLo92EBn6QFqtJJP9M
 tacZ447UPcRxCc6yFzFnZyuFatx17N80ZoygVLgj8GCbX04857ZVXsXyLYcq5LqG6RF5hVs/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284058>

On 14.01.16 14:28, =E9=83=AD=E8=85=BE=E9=A3=9E wrote:
Please no top-posting on this list.
> Hi Torsten B=C3=B6gershausen, thank you for the quick reply.
> I'm working on Mac OS as I have mentioned in the previous email.
>=20
> =E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 sw_vers -productVersion
> 10.11 OSX
>=20
> And besides, I use a case sensitive file system in OSX through the co=
mmand
> 'hdiutil create -volname 'case_fs' -type SPARSE -fs 'Case-sensitive
> Journaled HFS+' -size 100g ~/case_fs.sparseimage'
> Is this a known issue?
> Thank you!
>=20
> BRs
> terry3

No, this is typically what we observe on a case insensitive FS.
And that make me wonder what
git config core.ignorecase
says ?
