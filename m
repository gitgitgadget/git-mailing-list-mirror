From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 16:28:46 -0400
Message-ID: <3C02A99F-53DC-4B8A-8481-7A018FD7B397@kellerfarm.com>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <BvHZDf7-epsPOl8y5QrLcsmYgobmFUo7HwZanlekCciU8I-jiKPVRw@cipher.nrlssc.navy.mil> <23ECDEF1-BDEC-45CC-B0CC-7E1A7BFE00BB@kellerfarm.com> <AANLkTimbTUp4r8HPiYv2HxD-pLrrxW1qHiNhBHiknvkB@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 22:28:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxmyv-0006YK-MT
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 22:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757439Ab0ITU2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 16:28:51 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:36162 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754275Ab0ITU2u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 16:28:50 -0400
Received: from public-70-200.emich.edu ([164.76.70.200])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1Oxmyf-00087I-PA
	for git@vger.kernel.org; Mon, 20 Sep 2010 16:28:41 -0400
In-Reply-To: <AANLkTimbTUp4r8HPiYv2HxD-pLrrxW1qHiNhBHiknvkB@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156659>

On Sep 20, 2010, at 1:01 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> What does this return for you:
>=20
>    perl -MExtUtils::MakeMaker -le 'print $ExtUtils::MakeMaker::VERSIO=
N'

5.45

~ Andrew Keller
