From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: RE: [QUERY] How do you sort completions?
Date: Fri, 24 May 2013 18:20:24 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC1BF6DA0E@eusaamb103.ericsson.se>
References: <CALkWK0k=nVHOBe5SgRH9xQK1+yAYBzbNMqsWxhYPo0MTZPp63g@mail.gmail.com>
 <20130524161243.GB2104@goldbirke>
 <CALkWK0n8iuwNHfxV4AHUV+721pqLUOPhM6h+e0_opmkVuOV_4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 'Git List' <git@vger.kernel.org>,
	'Felipe Contreras' <felipe.contreras@gmail.com>
To: 'Ramkumar Ramachandra' <artagnon@gmail.com>,
	=?iso-8859-1?Q?=27SZEDER_G=E1bor=27?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 24 20:35:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufwpv-0001Sx-7M
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 20:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756390Ab3EXSf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 May 2013 14:35:27 -0400
Received: from usevmg20.ericsson.net ([198.24.6.45]:49287 "EHLO
	usevmg20.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab3EXSf0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 May 2013 14:35:26 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 May 2013 14:35:26 EDT
X-AuditID: c618062d-b7fb56d0000042e1-c8-519faf69b5cc
Received: from EUSAAHC007.ericsson.se (Unknown_Domain [147.117.188.93])
	by usevmg20.ericsson.net (Symantec Mail Security) with SMTP id E0.F5.17121.96FAF915; Fri, 24 May 2013 20:20:25 +0200 (CEST)
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC007.ericsson.se ([147.117.188.93]) with mapi id 14.02.0328.009; Fri,
 24 May 2013 14:20:24 -0400
Thread-Topic: [QUERY] How do you sort completions?
Thread-Index: AQHOWHMQ/lfcnuoIsU+U4jy/gCTuG5kUxTKAgAABq4D//97aYA==
In-Reply-To: <CALkWK0n8iuwNHfxV4AHUV+721pqLUOPhM6h+e0_opmkVuOV_4A@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.134]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsUyuXRPrG7m+vmBBkdny1usmvmY3eLg4zyL
	rivdTBa7W7McWDx2zrrL7vHuVAOrx+dNcgHMUVw2Kak5mWWpRfp2CVwZiydOYSvoYa3Y8foQ
	WwNjF0sXIweHhICJxLenfF2MnECmmMSFe+vZuhi5OIQEjjJKLG78yAThLGeUuL+6nwWkik1A
	T+LGz1vsILaIQI7ElM5drCA2s0C4xNa7U5lBbGEBQ4ml+zcyQdQYSRzqmcoKYTtJ/Gh9DVbD
	IqAqMf3GP7A5vAK+Ei9Ot0Bt3s0o8eTIW7AiToFAicmr7rKB2IwCshK7z15nglgmLnHryXwm
	iLMFJJbsOc8MYYtKvHz8jxXCVpZY8mQ/C0Q90NFTp7BB2NoSyxZCHMErIChxcuYTlgmMYrOQ
	jJ2FpGUWkpZZSFoWMLKsYuQoLU4ty003MtjECIyfYxJsujsY97y0PMQozcGiJM7bqj01UEgg
	PbEkNTs1tSC1KL6oNCe1+BAjEwenVAOjkEFaz5T+/t8e/b5SKvm//za29KY5SktN+SN98mtT
	Qp3d3yseXb8SeM+da03faipp1v5/fdZPRp8o7YxX7MEbUjZtEM3slO7c6Wi55vfHyDZbiVU7
	xZpELR7V+e2XnSC+b/ucJ8umB9W0O7CfmfA58eFmFgmut/dX5+fNeTGr9oK8penG/jYlluKM
	REMt5qLiRACI6hZcbQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225395>


> -----Original Message-----
> From: git-owner@vger.kernel.org=20
> [mailto:git-owner@vger.kernel.org] On Behalf Of Ramkumar Ramachandra
> Sent: Friday, May 24, 2013 12:19 PM
> To: SZEDER G=E1bor
> Cc: Git List; Felipe Contreras
> Subject: Re: [QUERY] How do you sort completions?
>=20
> SZEDER G=E1bor wrote:
> > I don't know who does the sorting (Bash or readline), and I=20
> don't know
> > any way to disable it.
>=20
> Damn; so it's impossible to have a custom-sorted completion list in
> bash.  Any idea about zsh?  I know that there are completion groups,
> but I'd really like custom sorting.

You could do that with tcsh :)