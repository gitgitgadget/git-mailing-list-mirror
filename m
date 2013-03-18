From: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
Subject: Re: building git ; need suggestion
Date: Mon, 18 Mar 2013 11:14:05 +0530
Message-ID: <C8080BF5-DC87-421D-97A1-DF5CF403A03A@infoservices.in>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in> <20130315124415.GA23122@paksenarrion.iveqy.com> <00107242-04EB-423F-90FE-A6DCDEE7E262@infoservices.in> <20130315131403.GA27022@google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Magnus_B=E4ck?= <baeck@google.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 06:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHSsB-0005NW-DG
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 06:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773Ab3CRFoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Mar 2013 01:44:12 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:55545
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703Ab3CRFoL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 01:44:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id C057FF06C04;
	Mon, 18 Mar 2013 11:14:10 +0530 (IST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifgCf92v2BC2; Mon, 18 Mar 2013 11:14:10 +0530 (IST)
Received: from [192.168.1.116] (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id DCCEFF06ABC;
	Mon, 18 Mar 2013 11:14:08 +0530 (IST)
In-Reply-To: <20130315131403.GA27022@google.com>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218393>


On 15-Mar-2013, at 6:44 PM, Magnus B=E4ck <baeck@google.com> wrote:
>>=20
>=20
> Right, but that's R/W permissions. Almost any piece of Git hosting
> software supports restriction of pushes. Discriminating *read* access
> between developers and maintenance people sounds like a disaster if i=
t's
> the same organisation.=20

Just restriction on push access is what required.
