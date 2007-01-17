From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Add a suffix option to git-format-patch
Date: Wed, 17 Jan 2007 17:57:41 +0100
Message-ID: <45AE5585.2040406@op5.se>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com> <87ps9d7j6t.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 17:58:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7E6l-0001zV-KD
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 17:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXAQQ5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 17 Jan 2007 11:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbXAQQ5o
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 11:57:44 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:51319 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566AbXAQQ5n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 11:57:43 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 99D7D6BD1F; Wed, 17 Jan 2007 17:57:41 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: =?ISO-8859-15?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <87ps9d7j6t.fsf@morpheus.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37015>

David K=E5gedal wrote:
> "Josh Boyer" <jwboyer@gmail.com> writes:
>=20
>> Hi All,
>>
>> I use git quite a bit to track my changes and then use
>> git-format-patch to generate patches to send on to others.  For the
>> most part, it works great but I find myself constantly doing:
>>
>> mv xxxx-foo.txt xxxx-foo.patch
>=20
> Seconded. I would even prefer .patch to be default, but I guess a
> config parameter would help me there.
>=20

Thirded, although I'd rather have it .gpatch, as it's a full commit wit=
h=20
message and all. It isn't necessarily usable with the 'patch' program=20
without manual massage first.

I can live with .txt though. Not many other files I keep around have=20
names quite like=20
0001-loadbalance_module-support-config-fanout-in-static-mesh.txt, so=20
it's not as if I frequently confuse them.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
