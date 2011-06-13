From: Peter TB Brett <peter@peter-b.co.uk>
Subject: Re: [stgit PATCH] stgit.el: Stop "Summary:" being added to all commit msgs.
Date: Mon, 13 Jun 2011 10:44:49 +0100
Organization: Surrey Space Centre
Message-ID: <acf4d471f1a1b1820b91bbdb7c7a1c76@mail.theimps.com>
References: <077cac32c74edaff2f20c84897bfc171@mail.theimps.com> <BANLkTikDdf_eVZJKezRG4e=091GpV8TGjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>,
	<git@vger.kernel.org>
To: =?UTF-8?Q?Gustav_H=C3=A5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 11:48:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW3lH-0000cN-R7
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 11:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab1FMJsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 05:48:42 -0400
Received: from mail.theimps.com ([81.91.110.43]:52932 "EHLO mail.theimps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab1FMJsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 05:48:42 -0400
Received: from mail.theimps.com (mail.theimps.com [127.0.0.1])
	by mail.theimps.com (Postfix) with ESMTP id 1BE70144D0;
	Mon, 13 Jun 2011 10:44:51 +0100 (BST)
Received: from mail.theimps.com (apache [172.16.1.101])
	(Authenticated sender: peter@peter-b.co.uk)
	by mail.theimps.com (Postfix) with ESMTPSA id 1A2CE144AE;
	Mon, 13 Jun 2011 10:44:50 +0100 (BST)
In-Reply-To: <BANLkTikDdf_eVZJKezRG4e=091GpV8TGjQ@mail.gmail.com>
X-Sender: peter@peter-b.co.uk
User-Agent: RoundCube Webmail/0.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175695>

On Mon, 13 Jun 2011 11:11:08 +0200, Gustav H=C3=A5llberg <gustav@gmail.=
com>
wrote:
> On Mon, Jun 13, 2011 at 10:37 AM, Peter TB Brett <peter@peter-b.co.uk=
>
> wrote:
>> Did I mention that this is *incredibly annoying*?
>=20
> I couldn't agree more, but if this is how all now-poor Emacs users
> will expect log-edit to behave, maybe we ought to follow suit with
> respect to adding christmas-tree-lit standard headers and such.
> For sure, your patch improves the current situation which is broken,
> but it's quite different from how git-status does it for example=E2=80=
=A6

Okay. The patch has another bug in that it causes the *previous* messag=
e
edited to get appended instead (WTF?) so please disregard this for now.

Is it possible to borrow the code from git.el?

Peter

--=20
Peter Brett <peter@peter-b.co.uk>
Remote Sensing Research Group
Surrey Space Centre
