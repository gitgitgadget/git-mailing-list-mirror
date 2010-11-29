From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: How to do with access control per repo with a smart http git server?
Date: Mon, 29 Nov 2010 08:44:20 +0000 (UTC)
Message-ID: <loom.20101129T094053-2@post.gmane.org>
References: <loom.20101124T035911-773@post.gmane.org> <20101124045025.GA12399@LK-Perkele-V2.elisa-laajakaista.fi> <loom.20101124T060650-817@post.gmane.org> <20101124060813.GA12949@LK-Perkele-V2.elisa-laajakaista.fi> <loom.20101124T082340-444@post.gmane.org> <loom.20101124T110708-253@post.gmane.org> <AANLkTi=1borEXoxZHKRQfPVhuLenp1mOQ7dezFCyKXQi@mail.gmail.com> <icoa0u$om4$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 29 09:45:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMzMX-0006um-Rc
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 09:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab0K2Iod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 03:44:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:38007 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab0K2Ioc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 03:44:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PMzLb-0006bl-A1
	for git@vger.kernel.org; Mon, 29 Nov 2010 09:44:31 +0100
Received: from 119.233.251.15 ([119.233.251.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 09:44:31 +0100
Received: from zhangchunlin by 119.233.251.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 09:44:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 119.233.251.15 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162377>

Chunlin Zhang <zhangchunlin <at> gmail.com> writes:
=20
> =E4=BA=8E 2010=E5=B9=B411=E6=9C=8826=E6=97=A5 06:35, Sverre Rabbelier=
 =E5=86=99=E9=81=93:
> > Heya,

> Ok,I will put it on github.But after some modification,because the=20
> current version is quick and dirty.

I have put my code to here: https://github.com/zhangchunlin/gitldapacl
