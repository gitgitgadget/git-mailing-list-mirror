From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH] t/lib-httpd: switch SANITY check for
 =?UTF-8?Q?NOT=5FROOT?=
Date: Sat, 24 Jan 2015 10:41:08 +0100
Organization: gmx
Message-ID: <2dba96fc1f2d52f4e103478a7827272d@www.dscho.org>
References: <20150114211712.GE1155@peff.net>
 <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
 <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
 <20150115222719.GA19021@peff.net>
 <xmqqa91j6537.fsf@gitster.dls.corp.google.com>
 <20150115235752.GB25120@peff.net>
 <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
 <20150116013256.GA25894@peff.net>
 <BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
 <20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>
 <xmqqfvba37bq.fsf@gitster.dls.corp.google.com>
 <xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de>
 <xmqq61bzwyqp.fsf@gitster.dls.corp.google.com> <54C170E9.4010401@web.de>
 <xmqqlhkusc4h.fsf@gitster.dls.corp.google.com> <54C2BC01.2030307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Kyle J. McKay" <mackyle@gmail.com>, msysgit@googlegroups.com,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 10:41:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YExDX-00043b-Fj
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 10:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbbAXJlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jan 2015 04:41:18 -0500
Received: from mout.gmx.net ([212.227.15.18]:55316 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbbAXJlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2015 04:41:15 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M9aX9-1YQC0w2U3D-00CxtQ; Sat, 24 Jan 2015 10:41:09
 +0100
In-Reply-To: <54C2BC01.2030307@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:9zG1qVTxBqx8SvHiR0OtP5bKqmcOsi6PPO/aUdfAVo3opphZGR+
 Xh+cfbE5p3gzBd+7CVAPmi8I/J0Ag2A6CDeLOVb/8Vov/2HlJ+UXX3VjCaFI8GoYU7Qg3mS
 Ads3E9BSfE9zz5NEQCDWTRGJSMtjqDi5B53DXNzS0uOv+qzCXQlB/DeHMH6Q3tDgxo/3qEs
 PTJUBclj3tgRD6bLokxIQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262991>

On 2015-01-23 22:24, Torsten B=C3=B6gershausen wrote:
> [...] either to always switch off SANITY for CYGWIN (or Windows in ge=
neral).

Nice one! You gave me the chuckle for the day ;-)

Ciao,
Dscho
