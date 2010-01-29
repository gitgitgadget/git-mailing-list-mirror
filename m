From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 14:12:24 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-6C7BCB.14122429012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <hjvgs1$rep$1@ger.gmane.org> <ron1-953427.13240429012010@news.gmane.org> <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com> <7vmxzwh906.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 23:12:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naz5D-0001z1-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 23:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab0A2WMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 17:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303Ab0A2WMu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 17:12:50 -0500
Received: from lo.gmane.org ([80.91.229.12]:39498 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011Ab0A2WMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 17:12:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Naz54-0001sc-Rp
	for git@vger.kernel.org; Fri, 29 Jan 2010 23:12:46 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 23:12:46 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 23:12:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138383>

In article <7vmxzwh906.fsf@alter.siamese.dyndns.org>,
 Junio C Hamano <gitster@pobox.com> wrote:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
>=20
> > On Fri, Jan 29, 2010 at 22:24, Ron Garret <ron1@flownet.com> wrote:
> >> Yes, I read that. =C2=A0But what I'm trying to do is not just *loo=
k* at the
> >> history, I want to restore my working tree to a previous version. =
=C2=A0The
> >> "Exploring History" section of the docs doesn't say how to do that=
=2E
> >
> > Do you want to restore your working tree only, or also throw away t=
he
> > history? If the former, you could look at 'git revert',...
>=20
> I think he wanted to check paths out of a commit and the set of paths
> happened to be "everything".
>=20
> IOW, "checkout $commit ."

Yes!!!  That's it exactly!

rg
