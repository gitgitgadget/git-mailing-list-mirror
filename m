From: zhifeng hu <zf@ancientrocklab.com>
Subject: Re: How to resume broke clone ?
Date: Thu, 28 Nov 2013 15:41:43 +0800
Message-ID: <560807D9-CE82-4CF6-A1CC-54E7CCA624F9@ancientrocklab.com>
References: <AAA12788-A242-41B8-B47D-1A0A52F33FC1@ancientrocklab.com> <5296F343.6050506@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Tr=E1=BA=A7n_Ng=E1=BB=8Dc_Qu=C3=A2n?= 
	<vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 08:42:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlwEd-0004rE-S7
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 08:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab3K1HmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 02:42:00 -0500
Received: from imap1.ox.registrar-servers.com ([198.187.29.233]:59074 "EHLO
	imap1.ox.registrar-servers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab3K1Hl7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 02:41:59 -0500
X-Greylist: delayed 16075 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2013 02:41:59 EST
Received: from localhost (localhost [127.0.0.1])
	by oxmail.registrar-servers.com (Postfix) with ESMTP id A1CFD200099;
	Thu, 28 Nov 2013 02:41:58 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at imap1.ox.registrar-servers.com
Received: from oxmail.registrar-servers.com ([127.0.0.1])
	by localhost (imap1.ox.registrar-servers.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30GcBdGvz2pm; Thu, 28 Nov 2013 02:41:58 -0500 (EST)
Received: from [192.168.1.101] (unknown [119.98.73.69])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by oxmail.registrar-servers.com (Postfix) with ESMTPSA id C6062200096;
	Thu, 28 Nov 2013 02:41:55 -0500 (EST)
In-Reply-To: <5296F343.6050506@gmail.com>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238475>

Thanks for reply, But I am developer, I want to clone full repository, =
I need to view code since very early.

zhifeng hu=20



On Nov 28, 2013, at 3:39 PM, Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwil=
dman@gmail.com> wrote:

> On 28/11/2013 10:13, zhifeng hu wrote:
>> Hello all:
>> Today i want to clone the Linux Kernel git repository.
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>=20
>> I am in china. our bandwidth is very limitation. Less than 50Kb/s.
> This repo is really too big.
> You may consider using --depth option if you don't want full history,=
 or
> clone from somewhere have better bandwidth
> $ git clone --depth=3D1
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> you may chose other mirror (github.com) for example
> see git-clone(1)
>=20
> --=20
> Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n.
>=20
