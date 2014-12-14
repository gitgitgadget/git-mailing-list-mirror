From: =?ISO-8859-15?Q?Christoph_Gr=FCninger?= <foss@grueninger.de>
Subject: Re: [wish] Revert changes in git gui
Date: Sun, 14 Dec 2014 19:25:42 +0100
Message-ID: <548DD626.5060102@grueninger.de>
References: <54875263.1010407@grueninger.de>	<548759C2.5030909@kdbg.org>	<CAKPyHN2OSARgsYtC0MAxXqe=LZnBC9eq9BxkGme0QTRhnH9a1g@mail.gmail.com>	<548AA6E6.5050805@grueninger.de> <CAKPyHN2sur9KHVkLGq2WPzvc5hLD8BfK-hA7EyZ=-3DTZRTRQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 19:25:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0Drd-0004vn-SJ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Dec 2014 19:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbaLNSZt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2014 13:25:49 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:32242 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaLNSZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2014 13:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1418581544; l=798;
	s=domk; d=grueninger.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Subject:CC:To:MIME-Version:From:Date;
	bh=HENgp/mnMuGsuADzPfbCheCsVOQ=;
	b=wp0JmtIx6PWnrCUeNMajEYMZepuaWB7vA+fBd330p5Ko4uXCH4jCwGdjbgKPtw7PQzj
	6BAqlptYhnha/1NaDn4Te/QrlxnWXabug2Imqfun0BdqmaET7VbnQTh64MMulJGlEN/60
	dgJWy9zoojzD7iVey//HbfVAc8MT0slzIZk=
X-RZG-AUTH: :PH4kclK9fvHEIDd1AEB/H6dKpHPYpRotT71NeUdfzJ23bUeXbp280AtBLOrd
X-RZG-CLASS-ID: mo00
Received: from [192.168.0.104] (HSI-KBW-46-223-95-214.hsi.kabel-badenwuerttemberg.de [46.223.95.214])
	by smtp.strato.de (RZmta 36.3 DYNA|AUTH)
	with ESMTPSA id y04308qBEIPhTzx
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate);
	Sun, 14 Dec 2014 19:25:43 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAKPyHN2sur9KHVkLGq2WPzvc5hLD8BfK-hA7EyZ=-3DTZRTRQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261401>

Hi Bert,
yes and no. I couldn't find a message from you requesting a merge of
this patch. Maybe it's me, I am not familiar with the way it works for =
Git.

@Git developers: Do you consider merging Bert's patch? If not, what's
the reason?

Bye
Christoph


On 12.12.2014 at 10:28, Bert Wesarg wrote:
> On Fri, Dec 12, 2014 at 9:27 AM, Christoph Gr=FCninger <foss@gruening=
er.de> wrote:
>> Hi Bert,
>> your commit is more than half a year old. Do you intent to include t=
hat
>> into Git master? If not, what's the reason?
>=20
> Thats a really odd question to a person who posted this patch to the
> mailling list the fist place, isn't it? If anything you should have
> asked the git gui developers and community, why they didn't show
> interest to have this in master, right?
>=20
> Bert
