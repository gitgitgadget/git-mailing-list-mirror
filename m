From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Hanging "git mv" on Windows bug report
Date: Tue, 19 May 2015 21:19:51 +0200
Organization: gmx
Message-ID: <982e5f6d4194acbb35ffcd5ea8834957@www.dscho.org>
References: <CANSw7Kw7A_kn6yue9TnvGSO9dFzvX8AUZkn0W98Euf384CbnFA@mail.gmail.com>
 <b4a67dd0e303e009a02055e2cb8785d5@www.dscho.org>
 <CANSw7KxvG29k28jp8Aq2ZeeNr2i=mWuirC6Ypno=_JXs7+TPqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yuval Greenfield <ubershmekel@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 21:20:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yun3Y-0000J8-1x
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbbESTTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 15:19:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:51114 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbbESTTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:19:55 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MBIAz-1Z4Rht1Qur-00ADQx; Tue, 19 May 2015 21:19:52
 +0200
In-Reply-To: <CANSw7KxvG29k28jp8Aq2ZeeNr2i=mWuirC6Ypno=_JXs7+TPqg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:sinSIpqHbOCspGiDrTrJgqlq+HbS8c6UhGmcVKkDRswuIM9ik8C
 dub40YKxab/oIdXf2jkE3x73qEc0sYxM5m5yTkuF904Og/tTQ2F0VdZcWpm3HFbSBZFlKSF
 Rn9Cjdejeib8jAKPU/ULXUziOO+QMr0vAvmiSeXAMCIxqScIpmDR49Dcv05LGPZ5QK1sasB
 k39GL2tKeyJvZ/gaZlIZw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269390>

Hi Yuval,

On 2015-05-19 19:11, Yuval Greenfield wrote:
>> $ git mv tmp Abc
>> fatal: bad source, source=tmp/myfile, destination=Abc/myfile
> 
> It works. Thanks.
> 
> I'd say this page at https://git-scm.com/download/win should point to
> https://github.com/git-for-windows/git/releases but sadly I don't have
> time to give you guys a pull request.

It is not ready yet. I did say "developers' preview", after all.

Ciao,
Johannes
