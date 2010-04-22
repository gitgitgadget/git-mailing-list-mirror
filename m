From: maximilian attems <max@stro.at>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 14:14:08 +0200
Message-ID: <20100422121408.GI3211@stro.at>
References: <20100421195822.GX10984@baikonur.stro.at>
 <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 14:14:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4vIX-0000xO-CN
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 14:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab0DVMOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 08:14:20 -0400
Received: from baikonur.stro.at ([213.239.196.228]:59935 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab0DVMOT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 08:14:19 -0400
Received: from dual (pa-67-234-122-227.dhcp.embarqhsd.net [67.234.122.227])
	by baikonur.stro.at (Postfix) with ESMTP id 7BD595C001;
	Thu, 22 Apr 2010 14:06:15 +0200 (CEST)
Received: by dual (Postfix, from userid 1000)
	id ED90A2408A; Thu, 22 Apr 2010 14:14:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145524>

On Thu, 22 Apr 2010, Tay Ray Chuan wrote:

> Hi,
>=20
> On Thu, Apr 22, 2010 at 3:58 AM, maximilian attems <max@stro.at> wrot=
e:
> > ~/src/linux-2.6$ git name-rev a1de02dccf906faba2ee2d99cac56799bda3b=
96a
> > =A0a1de02dccf906faba2ee2d99cac56799bda3b96a undefined
>=20
> have you fetched tags too?

~/src/linux-2.6$ git tag | grep v2.6.34-rc1

v2.6.34-rc1

did you try to reproduce at aboves repo the specific commit?
--=20
maks
