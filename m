From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: remote to push to local branch: hung up unexpectedly
Date: Wed, 13 Jan 2010 16:28:00 +0200
Message-ID: <20100113142800.GA13901@redhat.com>
References: <20100113130843.GA13545@redhat.com> <be6fef0d1001130615k17855680s57952498260ad09d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 15:31:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV4Fj-0004Sj-78
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 15:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138Ab0AMObE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 09:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534Ab0AMOa7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 09:30:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524Ab0AMOa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 09:30:57 -0500
Received: from int-mx03.intmail.prod.int.phx2.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o0DEUtNl026437
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 13 Jan 2010 09:30:56 -0500
Received: from redhat.com (vpn2-11-140.ams2.redhat.com [10.36.11.140])
	by int-mx03.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o0DEUsxX022048;
	Wed, 13 Jan 2010 09:30:54 -0500
Content-Disposition: inline
In-Reply-To: <be6fef0d1001130615k17855680s57952498260ad09d@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136824>

On Wed, Jan 13, 2010 at 10:15:38PM +0800, Tay Ray Chuan wrote:
> Hi,
>=20
> On Wed, Jan 13, 2010 at 9:08 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
> > with url =3D /scm/qemu =A0 (this is repo path)
>=20
> Are you working in a "normal" git setup with a .git folder and the
> files checked out? Or are you working with a --bare repo?

It's a normal setup.

> --=20
> Cheers,
> Ray Chuan
