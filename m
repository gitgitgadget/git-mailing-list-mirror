From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4] blame: CRLF in the working tree and LF in the repo
Date: Fri, 01 May 2015 20:57:27 +0200
Message-ID: <5543CC97.4080702@web.de>
References: <55436852.3030002@web.de> <xmqqbni4xlt7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, kasal@ucw.cz
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri May 01 20:57:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoG82-0002DI-QM
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 20:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbbEAS5g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 14:57:36 -0400
Received: from mout.web.de ([212.227.17.11]:55452 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623AbbEAS5d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 14:57:33 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MdLsF-1YVlnu2NjH-00ITPc; Fri, 01 May 2015 20:57:29
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <xmqqbni4xlt7.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:t4aOkUWI+fd+llhXOhtyuUbNO2WPJVwzgkGbhq+DeFL4IkSeXuU
 LOpVxbCu3eByxhGd8l3G/5JpvcazJfYMP8o460Hw60UrjHPJXVTJ93WX9CtBIj10oMPQvqJ
 Q61mzFqTrK7bR5dDoZFF849GOTS0ONB6Uyvk4K8qpGCbvgl0NwGCehE59SbXxC6IpQ/eyaN
 txJD8bXPMHPuPfqFaiGqw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268172>

On 2015-05-01 19.13, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> A typical setup under Windows:
>> core.eol is CRLF and a file is marked as "text" in .gitattributes,
>> or core.autocrlf is true
>=20
> A full sentence (a proper prose) is easier to read.  The above is
> unclear if that is what you are unilaterally declaring, a statement
> of fact, or something else (see what I queued based on the previous
> round on 'pu').

OK, let's go for that, thanks for amending.
And is there a chance to correct my mis-spelling ?

s/A typicall/A typical/=20
