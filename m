From: Pirate Praveen <praveen@debian.org>
Subject: Re: t7300-clean.sh fails "not ok 32 - should avoid cleaning possible submodules" on debian jessie
Date: Tue, 07 Jun 2016 21:50:06 +0530
Message-ID: <1A6C20FA-43F0-43AF-B38D-E88EE760F96F@debian.org>
References: <5756856A.4020406@debian.org> <alpine.DEB.2.20.1606071229500.28610@virtualbox> <5756C6F4.5050300@debian.org> <CAGZ79ka5J9xEW=ps6kM6Gm2NU67_hv792-dJThf=GOd0tZG-Mw@mail.gmail.com> <CAGZ79kYb0+=fr_wp4FOMdCcNL2O0D9ktJLDqGs6DueRg+7aO9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 18:30:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAJk7-0006Yj-2z
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 18:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161774AbcFGQUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 12:20:30 -0400
Received: from sub5.mail.dreamhost.com ([208.113.200.129]:38527 "EHLO
	homiemail-a94.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983AbcFGQU1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 12:20:27 -0400
Received: from homiemail-a94.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a94.g.dreamhost.com (Postfix) with ESMTP id 4F9D238A059;
	Tue,  7 Jun 2016 09:20:26 -0700 (PDT)
Received: from [192.168.1.100] (unknown [14.97.231.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: me@j4v4m4n.in)
	by homiemail-a94.g.dreamhost.com (Postfix) with ESMTPSA id 4D79538A058;
	Tue,  7 Jun 2016 09:20:23 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGZ79kYb0+=fr_wp4FOMdCcNL2O0D9ktJLDqGs6DueRg+7aO9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296695>



On 2016, =E0=B4=9C=E0=B5=82=E0=B5=BA 7 9:16:01 PM IST, Stefan Beller <s=
beller@google.com> wrote:
>On Tue, Jun 7, 2016 at 8:43 AM, Stefan Beller <sbeller@google.com>
>wrote:
>> (Are you telling me that patch is faulty?)
>
>The patch is not part of v2.8.1 but part of v2.8.3,
>so take a later version, or cherry-pick that patch manually.

Thanks! I have ignored that test failure for now. Good to know its fixe=
d in 2.8.3.
