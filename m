From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2] doc: make clear --assume-unchanged's user contract
Date: Tue, 9 Dec 2014 08:13:16 -0000
Organization: OPDS
Message-ID: <CD806F4871C843B399611747A4B57035@PhilipOakley>
References: <1417878270-4364-1-git-send-email-philipoakley@iee.org> <1417878270-4364-2-git-send-email-philipoakley@iee.org> <1418096636.19104.31.camel@segulix> <39592B1FCE234EA58078EBFB34171859@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed	reply-type=response
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Duy Nguyen" <pclouds@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>,
	"Michael J Gruber" <git@drmicha.warpmail.net>
To: =?ISO-8859-15?Q?S=E9rgio_Basto?= <sergio@serjux.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 09:13:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyFv5-000399-0c
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 09:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbaLIINP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Dec 2014 03:13:15 -0500
Received: from b216.a.smtp2go.com ([216.22.18.216]:36367 "EHLO
	b216.a.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaLIINO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 03:13:14 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261113>

=46rom: "Philip Oakley" <philipoakley@iee.org>
> From: "S=E9rgio Basto" <sergio@serjux.com>
>> On S=E1b, 2014-12-06 at 15:04 +0000, Philip Oakley wrote:
>>> Many users misunderstand the --assume-unchanged contract, believing
>>> it means Git won't look at the flagged file.
[...]
> retrospect, so my patch seeks to clarify the existing situation. That=
=20
> is "please git, update the index, you can assume these files are=20
> unchanged ... ".
=2E.. and if you don't  trust me, then you can even go and check=20
[Honestly,  you can trust me I'm a developer]"
--
the extra bit.
Philip
