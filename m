From: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Subject: Re: [StGit] Import file(s) problem
Date: Sat, 29 Nov 2008 00:31:23 +0900
Message-ID: <49300ECB.5090401@ruby.dti.ne.jp>
References: <492EC5F5.2050807@ruby.dti.ne.jp> <b0943d9e0811271406u6768f45csdb5ae775436404b8@mail.gmail.com> <20081128092556.GA4380@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 16:35:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L65N6-0000G5-JM
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 16:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYK1Pbe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Nov 2008 10:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbYK1Pbe
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 10:31:34 -0500
Received: from smtp14.dti.ne.jp ([202.216.231.189]:65350 "EHLO
	smtp14.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbYK1Pbd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 10:31:33 -0500
Received: from [192.168.1.3] (PPPax805.tokyo-ip.dti.ne.jp [210.159.155.55]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id mASFVNnC013697;Sat, 29 Nov 2008 00:31:26 +0900 (JST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20081128092556.GA4380@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101878>

Karl Hasselstr=F6m wrote:
> On 2008-11-27 22:06:01 +0000, Catalin Marinas wrote:
>=20
>> The '..' construct has special meaning in both Git and StGit meaning
>> an interval of commits or patches. We'll need to reject patch names
>> with '..' to avoid such errors.
>=20
> I added a note to the bug database:
>=20
>   https://gna.org/bugs/index.php?10919

Looking forward to being fixed, thanks.

  Shinya
