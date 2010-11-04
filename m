From: Kevin Ballard <kevin@sb.org>
Subject: Re: can subversion 1.6 be made "just as distributed as git"?
Date: Thu, 4 Nov 2010 02:27:26 -0700
Message-ID: <EE766BAE-E930-46EB-BB89-FE83C7597169@sb.org>
References: <loom.20101104T014408-903@post.gmane.org> <BF8EE51A-AFE4-4EBA-82E8-4A8B32678FBF@sb.org> <AANLkTim0N99M488k3vR5zVDkZv7Wz-08hRwdy0jaHh4c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: MDellerus <mdellerus@yahoo.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:27:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDw6d-0001XG-2z
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581Ab0KDJ1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 05:27:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41540 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab0KDJ1a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 05:27:30 -0400
Received: by ywc21 with SMTP id 21so1190948ywc.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 02:27:29 -0700 (PDT)
Received: by 10.231.171.2 with SMTP id f2mr246445ibz.63.1288862849697;
        Thu, 04 Nov 2010 02:27:29 -0700 (PDT)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id 8sm12548309iba.10.2010.11.04.02.27.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Nov 2010 02:27:28 -0700 (PDT)
In-Reply-To: <AANLkTim0N99M488k3vR5zVDkZv7Wz-08hRwdy0jaHh4c@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160704>

On Nov 4, 2010, at 2:26 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Thu, Nov 4, 2010 at 01:58, Kevin Ballard <kevin@sb.org> wrote:
>> Using "svnadmin hotcopy" you could certainly get your own local repo=
, but I fail to
>> see how you could easily join your history up with someone else's hi=
story using this
>> mechanism. If you really want to use SVN in a distributed manner, I =
would recommend
>> you simply use SVK.
>=20
> SVK gives you *disconnected* SVN, not distributed. You still can't
> (easily) share your
> uncommited revisions with others. It just solves the problem of you
> being on a plane
> for a few hours. It doesn't turn SVN into Git.

SVK bills itself as providing distributed patches, and calls itself "A =
Distributed
Version Control System". I do agree that it's mainly useful for using S=
VN in a
disconnected mode, but I trust that there's at least some facility for =
sharing
local branches with other SVK users, though I've certainly never done t=
hat myself.

-Kevin Ballard