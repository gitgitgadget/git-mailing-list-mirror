From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 21:20:50 +0200
Message-ID: <20130609192050.GD2091@goldbirke>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
 <20130609171810.GA10858@goldbirke>
 <CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
 <20130609173342.GB2091@goldbirke>
 <20130609173739.GF22905@serenity.lan>
 <CAMP44s1F5O3vjHuL=cGys=p_dbnnE-f-Mv+j5Q1ZbyVAJCjLSA@mail.gmail.com>
 <20130609190103.GG22905@serenity.lan>
 <CAMP44s15nxOmZb4L5qGJ1+6dy0DkUTnCq6u=SRJgqO18tK-H4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:21:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllAk-0000Lk-Gi
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab3FITU6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 15:20:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52416 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3FITU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:20:57 -0400
Received: from localhost6.localdomain6 (f051160074.adsl.alicedsl.de [78.51.160.74])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MW9RR-1UsagV3nib-00XrbV; Sun, 09 Jun 2013 21:20:51 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s15nxOmZb4L5qGJ1+6dy0DkUTnCq6u=SRJgqO18tK-H4Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Go1ij4MkQwfer+RcStFKHDYEezHy6iekuyuBqWdeY25
 7Ll1f7Qq7pXtdz/vrkBxDa6PAtL/lI9fl4jTzyATL+w/vGr1BA
 KJmzszEQhZdjhchQF4A7rogEJNFptEL1vxlQaPzCEuPtOwi3oe
 4FNUy+j8BR1bFgL7BSCDEj/uRlIREHnMrIslYEpye7ZUIw04K5
 JXDDPc1xW3rCxuU/QUS+Chz70aZO51KFA1XSVVm4tcTeCCueaa
 eE4QS7it6O7WfUnIQlSAjq8wKSlfZ7e+Am+rmFWq92pkSD4do6
 LrQZHN6bRax5I9OuebsDKAuaV+pxYE+H/wK0iYVos///d9HOqX
 OZSLa27WNakUFpydtf2Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227107>

On Sun, Jun 09, 2013 at 02:11:18PM -0500, Felipe Contreras wrote:
> Perhaps "trivial memory leak fix" would be better.

That's fine with me, thanks.

If only we could have got there like 10 emails ago.


G=E1bor
